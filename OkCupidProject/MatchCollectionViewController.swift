//
//  MatchCollectionViewController.swift
//  OkCupidProject
//
//  Created by David Nadri on 10/20/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MatchCollectionViewController: UICollectionViewController {

    var matches = [Match?]()
    private let reuseIdentifier = "MatchCell"
    let screenSize = UIScreen.mainScreen().bounds
    
    // - MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
//        ApiClient.requestMatches({ match in
//            print("match: \(match)")
//            
//        }, onError: { error in
//                print(error.localizedDescription)
//        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        getMatches()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    // - MARK: UICollectionViewDelegate
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matches.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MatchCollectionViewCell
        
        guard let match = matches[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        //cell.matchObject = match
        //cell.configure()

        if let photoURL = match.photoURL {
            UIView.animateWithDuration(1.5, delay: 0, options: .CurveEaseIn, animations: {
                cell.photoImageView.alpha = 1.0
                cell.photoImageView.loadImageWithUrlString(photoURL)
            }, completion: nil)
        }
        
        if let username = match.username {
            cell.usernameLabel.text = username
        }
        
        guard let age = match.age, let cityName = match.cityName, let stateCode = match.stateCode else {
            return UICollectionViewCell()
        }
        cell.userDetailsLabel.text = "\(age) • \(cityName), \(stateCode)"
        
        if let matchPercent = match.matchPercent {
            cell.matchPercentLabel.text = "\(Int(matchPercent/100))% Match"
        }
        
        if let isOnline = match.isOnline {
            if isOnline == 1 {
                cell.onlineIndicatorView.backgroundColor = UIColor.greenColor()
            } else {
                cell.onlineIndicatorView.backgroundColor = UIColor.clearColor()
            }
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(screenSize.width/2 - 1.0, screenSize.width - 50.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func configureView() {
        self.title = "Matches"
        //Collection view background color: HEX#ecedf2 or rgb(236,237,242)
        collectionView?.backgroundColor = UIColor(red: 236.0/255.0, green: 237.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        
    }
    
    func getMatches() {
        
        // Remove all the matches from the array and keep the capacity
        self.matches.removeAll(keepCapacity: true)
        
        let endpoint = "https://www.okcupid.com/matchSample.json"
        
        Alamofire.request(.GET, endpoint)
            .validate()
            .responseJSON { response in
                
                if let matchData = response.result.value {
                    let json = JSON(matchData)
                    
                    if let matches = json["data"].array {
                        
                        for match in matches {
                            print("match in JSON: \(match)")
                            
                            guard let photoURL = match["photo"]["full_paths"]["original"].string else {
                                return
                            }
                            print("photoURL: \(photoURL)")
                            
                            guard let username = match["username"].string else {
                                return
                            }
                            print("username: \(username)")
                            
                            guard let age = match["age"].int else {
                                return
                            }
                            print("age \(age)")
                            
                            guard let cityName = match["location"]["city_name"].string else {
                                return
                            }
                            print("cityName: \(cityName)")
                            
                            guard let stateCode = match["location"]["state_code"].string else {
                                return
                            }
                            print("stateCode: \(stateCode)")
                            
                            guard let matchPercent = match["match"].int else {
                                return
                            }
                            print("matchPercent: \(matchPercent)")
                            
                            guard let isOnline = match["is_online"].int else {
                                return
                            }
                            print("isOnline: \(isOnline)")
                            
                            let match = Match(photoURL: photoURL, username: username, age: age, cityName: cityName, stateCode: stateCode, matchPercent: matchPercent, isOnline: isOnline)
                            
                            self.matches.append(match)
                            
                        }
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            self.collectionView?.reloadData()
                        }
                        
                    }
                    
                    
                } else {
                    
                    print("ERROR: \(response.result.error)")
                    let alert = UIAlertController(title: "Error", message: "\(response.result.error)", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    alert.presentViewController(alert, animated: true, completion: nil)
                    
                }
                
                
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

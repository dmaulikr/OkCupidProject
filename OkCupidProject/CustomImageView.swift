//
//  CustomImageView.swift
//  OkCupidProject
//
//  Created by David Nadri on 10/27/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache()

// This class includes a function which is called on UIImageViews, of type CustomImageView, to avoid:
// 1. Cells displaying the wrong images (i.e.: when scrolling quickly)
// 2. Protects 1. from happening when user is loading the app on a poor connection
class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageWithUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = NSURL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.objectForKey(urlString) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            // Important: Update UI back on main thread
            dispatch_async(dispatch_get_main_queue(), {
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString)
            })
            
        }).resume()
    }
    
}


//
//  MatchCollectionViewCell.swift
//  OkCupidProject
//
//  Created by David Nadri on 10/20/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit

class MatchCollectionViewCell: UICollectionViewCell {

    var matchObject: Match?
    
    @IBOutlet weak var photoImageView: CustomImageView! {
        didSet {
            photoImageView.alpha = 0.0
        }
    }
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userDetailsLabel: UILabel!
    @IBOutlet weak var matchPercentLabel: UILabel!
    @IBOutlet weak var customCellView: UIView! {
        didSet {
            customCellView.layer.cornerRadius = 4.0
            customCellView.layer.shadowColor = UIColor.lightGrayColor().CGColor
            customCellView.layer.shadowOffset = CGSizeMake(2, 2)
            customCellView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var onlineIndicatorView: UIView! {
        didSet {
            onlineIndicatorView.backgroundColor = UIColor.clearColor()
            onlineIndicatorView.layer.cornerRadius = onlineIndicatorView.frame.size.height/2
            onlineIndicatorView.layer.masksToBounds = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//      // Configure the collection view cell: card layout
//        self.contentView.backgroundColor = UIColor(red: 236.0/255.0, green: 237.0/255.0, blue: 242.0/255.0, alpha: 1.0)
//        let customCellView = UIView(frame: CGRectMake(0, 0, 250.0, 407.0))
//        customCellView.layer.backgroundColor = UIColor.whiteColor().CGColor
//        customCellView.layer.masksToBounds = false
//        
//        self.contentView.addSubview(customCellView)
//        self.contentView.sendSubviewToBack(customCellView)
    }
    
//    func configure() {
//        
//        if let object = matchObject {
//            // Improvement: Move code from cellForItemAtIndexPath to here
//        }
//        
//    }
    
//    Improvement: Sets the placeolder image to the cell's imageView before it gets reused with old image
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.photoImageView.image = UIImage(named: placeholder)
//    }
    
}

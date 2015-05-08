//
//  RSSTableViewCell.swift
//  RSSReader
//
//  Created by Graeme Fulton on 23/11/2014.
//  Copyright (c) 2014 Graeme Fulton. All rights reserved.
//http://www.weheartswift.com/swifting-around/

import UIKit

class RSSTableViewCell: UITableViewCell {
    

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadItem(#title:String, subTitle:String, image:String){
        
        self.title.text = title
        self.subTitle.text = subTitle
   
        ImageLoader.sharedLoader.imageForUrl(image, completionHandler:{(image: UIImage?, url: String) in
            self.picture.image = image
        })
        
        //self.picture.loadImage(image, autoCache: true)
        //set the image
//        self.picture.image =  UIImage(data: NSData(contentsOfURL: NSURL(string:image)!)!)
        
        //http://www.raywenderlich.com/forums/viewtopic.php?f=2&t=12171
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //self.picture.image =  UIImage(data: NSData(contentsOfURL: NSURL(string:image)!)!)
        })
        
        //self.picture.image = UIImage(contentsOfFile: image)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

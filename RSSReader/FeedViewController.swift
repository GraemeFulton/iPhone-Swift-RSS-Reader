//
//  FeedViewController.swift
//  RSSReader
//
//  Created by Graeme Fulton on 12/11/2014.
//  Copyright (c) 2014 Graeme Fulton. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
 
    
    @IBOutlet var textView: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    
    var selectedFeedTitle = String()
    var selectedFeedFeedContent = String()
    var selectedFeedURL = String()
    var selectedImage = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //populate textview
        textView.text="\(selectedFeedTitle)\n\(selectedFeedFeedContent)"
        
        ImageLoader.sharedLoader.imageForUrl(selectedImage, completionHandler:{(image: UIImage?, url: String) in
            self.pictureView.image = image
        })

        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "openWebPage" {
            
            let fvc: FeedViewController = segue.destinationViewController as FeedViewController
            selectedFeedURL =  selectedFeedURL.stringByReplacingOccurrencesOfString(" ", withString:"")
            selectedFeedURL =  selectedFeedURL.stringByReplacingOccurrencesOfString("\n", withString:"")
            fvc.selectedFeedURL = selectedFeedURL

            selectedImage =  selectedImage.stringByReplacingOccurrencesOfString(" ", withString:"")
            selectedImage =  selectedImage.stringByReplacingOccurrencesOfString("\n", withString:"")

            fvc.selectedImage = selectedImage
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

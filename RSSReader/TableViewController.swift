//
//  TableViewController.swift
//  RSSReader
//
//  Created by Graeme Fulton on 10/11/2014.
//  Copyright (c) 2014 Graeme Fulton. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate {

    var myFeed : NSArray = []
    var url: NSURL = NSURL()
    
    var selectedTitle : String = ""
    var selectedContent : String = ""
    var selectedUrl : String = ""
    var selectedImage : String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.rowHeight = 70
        
        url = NSURL(string:"https://dribbble.com/shots/popular.rss")!

        self.load_url(url)
        
        var nib = UINib(nibName: "RSSTableViewCell", bundle:nil)
        tableView.registerNib(nib, forCellReuseIdentifier:"rssCell")

    }
    
    func load_url(url:NSURL){
    
        // XmlParserManager instance/object/variable
        var myParser : XMLParserManager = XMLParserManager()
        myParser.initWithURL(url)
        // Put feed in array
        myFeed = myParser.feeds
        
        tableView.reloadData()
        
    }

    
    func parserDidEndDocument(parser: NSXMLParser!) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myFeed.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:RSSTableViewCell = tableView.dequeueReusableCellWithIdentifier("rssCell", forIndexPath: indexPath) as RSSTableViewCell

        // Configure the cell...
        var ttl:String = myFeed.objectAtIndex(indexPath.row).objectForKey("title") as String
        var sub:String = myFeed.objectAtIndex(indexPath.row).objectForKey("author") as String
        var pic:String = myFeed.objectAtIndex(indexPath.row).objectForKey("description") as String
        
        cell.loadItem(title: ttl, subTitle: sub, image:pic )
        return cell
    }
    
    
    //http://stackoverflow.com/questions/26236975/prepareforsegue-not-called-from-custom-uitableviewcell
    //  println("You selected cell #\(indexPath.row)!")

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        self.selectedTitle = myFeed[indexPath.row].objectForKey("title") as String
        self.selectedContent = myFeed[indexPath.row].objectForKey("author") as String
        self.selectedUrl = myFeed[indexPath.row].objectForKey("link") as String
        self.selectedImage = myFeed[indexPath.row].objectForKey("description") as String
        
        performSegueWithIdentifier("openPage", sender: cell)

    }

  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
                if segue.identifier == "openPage" {
                                let fvc: FeedViewController = segue.destinationViewController as FeedViewController
                    
                    fvc.selectedFeedTitle = self.selectedTitle
                                fvc.selectedFeedFeedContent = self.selectedContent
                                fvc.selectedFeedURL = self.selectedUrl
                    fvc.selectedImage = self.selectedImage
                    
        }
    }
    
//http://makeapppie.com/2014/07/12/swift-swift-how-to-use-uitableview-in-swift/

//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
//        
//        // Configure the cell...
//        cell.textLabel.text = (myFeed.objectAtIndex(indexPath.row).objectForKey("title") as String)
//        cell.detailTextLabel?.numberOfLines = 3
//        cell.detailTextLabel?.text = (myFeed.objectAtIndex(indexPath.row).objectForKey("description") as String)
//        
//        return cell
//    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if segue.identifier == "openPage" {
//            
//            var indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
//            //let selectedFeedURL: String = feeds[indexPath.row].objectForKey("link") as String
//            let selectedTitle: String = myFeed[indexPath.row].objectForKey("title") as String
//            let selectedContent: String = myFeed[indexPath.row].objectForKey("description") as String
//            let selectedURL: String = myFeed[indexPath.row].objectForKey("link") as String
//            
//            // Instance of our feedpageviewcontrolelr
//            let fvc: FeedViewController = segue.destinationViewController as FeedViewController
//            
//            fvc.selectedFeedTitle = selectedTitle
//            fvc.selectedFeedFeedContent = selectedContent
//            fvc.selectedFeedURL = selectedURL
//        }
//    }
    

}

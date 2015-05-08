//
//  XMLParserManager.swift
//  RSSReader
//
//  Created by Graeme Fulton on 11/11/2014.
//  Copyright (c) 2014 Graeme Fulton. All rights reserved.
//

import Foundation

class XMLParserManager: NSObject, NSXMLParserDelegate {
   
    var parser = NSXMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var ftitle = NSMutableString()
    var link = NSMutableString()
    var fauthor = NSMutableString()
    var fdescription = NSMutableString()
    
    var fimage = NSMutableString()
    
    var counter = 0

    
    // initilise parser
    func initWithURL(url :NSURL) -> XMLParserManager {
        startParse(url)
        return self
    }
    
    func startParse(url : NSURL){
        //initialize parser
        feeds=[]
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }
    
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        
        element = elementName
        
        if (element as NSString).isEqualToString("item"){
            
            elements = NSMutableDictionary()
            elements = [:]
            ftitle = NSMutableString()
            ftitle = ""
            link = NSMutableString()
            link = ""
            fauthor = NSMutableString()
            fauthor = ""
//            fdescription = NSMutableString()
//            fdescription = ""
            fimage = NSMutableString()
            fimage = ""
            
        }
        
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        
        
        if (elementName as NSString).isEqualToString("item"){
            if counter<10{
            if (ftitle !== ""){
                elements.setObject(ftitle, forKey: "title")
                
            }
            if (link !== ""){
                elements.setObject(link, forKey: "link")
                
            }
            if (fauthor !== ""){
                elements.setObject(fauthor, forKey: "author")
                
            }
//            if (fdescription !== ""){
//                elements.setObject(fdescription, forKey: "description")
//                
//            }
            if (fimage !== ""){
                elements.setObject(fimage, forKey: "description")
                
            }
            
            feeds.addObject(elements)
            }
            counter += 1
        }
        
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        
        if element.isEqualToString("title"){
            ftitle.appendString(string)
        }else if element.isEqualToString("link"){
            link.appendString(string)
        }
        else if element.isEqualToString("author"){
            fauthor.appendString(string)
        }
        else if element.isEqualToString("description"){
            //normally you'd append to fdescription, but here we use getImage to extract an image url from the dribbble desceription
            var image = getImage(string)
            println(image)
            fimage.appendString(image)
        }
        
    }
    
    func getImage(desc:String)->String{
    
        var imageFetch: ImageFetcher = ImageFetcher()
        var image = imageFetch.getImagefromString(desc)
        image = image.lowercaseString
        
        var formattedImage = image.stringByReplacingOccurrencesOfString("(null)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)

        
        return formattedImage
    }
    
 
    
    
    
}

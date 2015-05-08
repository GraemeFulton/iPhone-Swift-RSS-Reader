//
//  ImageFetcher.m
//  RSSReader
//
//  Created by Graeme Fulton on 23/11/2014.
//  Copyright (c) 2014 Graeme Fulton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ImageFetcher.h"

@implementation ImageFetcher

- (NSString*) getImagefromString:(NSString*)html {
    
//http://stackoverflow.com/questions/6310773/nsstring-with-some-html-tags-how-can-i-search-for-img-tag-and-get-the-content
    
    NSString *url = nil;
    NSString *htmlString = html;
    NSScanner *theScanner = [NSScanner scannerWithString:htmlString];
    // find start of IMG tag
    [theScanner scanUpToString:@"<img" intoString:nil];
    if (![theScanner isAtEnd]) {
        [theScanner scanUpToString:@"src" intoString:nil];
        NSCharacterSet *charset = [NSCharacterSet characterSetWithCharactersInString:@"\"'"];
        [theScanner scanUpToCharactersFromSet:charset intoString:nil];
        [theScanner scanCharactersFromSet:charset intoString:nil];
        [theScanner scanUpToCharactersFromSet:charset intoString:&url];
        // "url" now contains the URL of the img
       // NSLog(@"%@",url);
    }
    return [NSString stringWithFormat:@"%@",url];
}

@end
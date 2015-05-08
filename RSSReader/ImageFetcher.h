//
//  ImageFetcher.h
//  RSSReader
//
//  Created by Graeme Fulton on 23/11/2014.
//  Copyright (c) 2014 Graeme Fulton. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface ImageFetcher : NSObject

@property (strong, nonatomic) id someProperty;

- (NSString*) getImagefromString:(NSString*)html;

@end


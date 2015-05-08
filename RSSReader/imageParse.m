//
//  imageParse.m
//  RSSReader
//
//  Created by Graeme Fulton on 23/11/2014.
//  Copyright (c) 2014 Graeme Fulton. All rights reserved.
//

#import <Foundation/Foundation.h>

HTMLNode *bodyNode = [parser body];

NSArray *imageNodes = [bodyNode findChildTags:@"div"];
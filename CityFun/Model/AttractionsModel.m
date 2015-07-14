//
//  AttractionsModel.m
//  CityFun
//
//  Created by Shih-Ming Tung on 7/13/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "AttractionsModel.h"

@interface AttractionsModel()

@end

@implementation AttractionsModel

//file property setter
- (void)setFile:(NSString *)file
{
    NSRange range = [[file lowercaseString] rangeOfString:@".jpg"];
    if (range.length == 0) {
        range = [[file lowercaseString] rangeOfString:@".png"];
    }
    _file = [file substringToIndex:range.location + range.length];
}

static NSMutableArray *currentData = nil;

+ (NSArray*)getAttractions
{
    return currentData;
}

+ (void)setCurrentData:(NSArray*)attractions{
    currentData = [NSMutableArray arrayWithArray:attractions];
}

@end

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

+ (NSArray*)getAttractionsByIds:(NSArray *)attractionIDs{
    
    NSMutableArray *attractions = [[NSMutableArray alloc] init];
    //find attraction data in all acctractions
    for (id attrId in attractionIDs){
        for (AttractionsModel *obj in currentData) {
            if (obj._id == [attrId integerValue]) {
                [attractions addObject:obj];
            }
        }
    }
    return attractions;
}

+ (void)setCurrentData:(NSArray*)attractions{
    currentData = [NSMutableArray arrayWithArray:attractions];
}

@end

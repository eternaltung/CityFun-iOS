//
//  AttractionsModel.h
//  CityFun
//
//  Created by Shih-Ming Tung on 7/13/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "JSONModel.h"

@protocol AttractionsModel
@end

@interface AttractionsModel : JSONModel
@property (assign, nonatomic) int _id;
@property (strong, nonatomic) NSString *stitle;
@property (strong, nonatomic) NSString *xbody;
@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) float longitude;
@property (assign, nonatomic) float latitude;
@property (strong, nonatomic) NSString *xpostDate;
@property (strong, nonatomic) NSString *file;

+(NSArray*)getAttractions;
+(NSArray*)getAttractionsByIds:(NSArray *)attractionIDs;
+(void)setCurrentData:(NSArray*)attractions;

@end
//
//  UserModel.h
//  CityFun
//
//  Created by Shih-Ming Tung on 7/19/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface UserModel : NSObject

@property (strong, nonatomic) NSString *id;
@property (assign, nonatomic) int placeID;

+(void)setUserClient:(NSString*)url key:(NSString*)key;
+(MSClient*)getUserClient;
+(void)getFavorites:(void (^)(NSMutableArray *favorites))complete;
+(void)updateFavorites:(int)attractionID dataID:(NSString*)dataID isadd:(BOOL)isadd complete:(void (^)(UserModel *user))complete;
+(void)saveUser:(NSString*)userID;
@end

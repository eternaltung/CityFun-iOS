//
//  UserModel.m
//  CityFun
//
//  Created by Shih-Ming Tung on 7/19/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "UserModel.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface UserModel()

@end

@implementation UserModel

+(void)setUserClient:(NSString*)url key:(NSString*)key
{
    client = [MSClient clientWithApplicationURLString:url applicationKey:key];
}

static MSClient *client = nil;

+(MSClient*)getUserClient
{
    return client;
}
@end

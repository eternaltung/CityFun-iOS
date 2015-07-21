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

+(void)setUserClient:(NSString*)url key:(NSString*)key;
+(MSClient*)getUserClient;
@end

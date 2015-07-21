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

static NSMutableArray *favorites = nil;

+(void)getFavorites:(void (^)(NSMutableArray *favorites))complete
{
    if (favorites == nil)
    {
        favorites = [NSMutableArray new];
        table = [client tableWithName:@"Cityfun"];
        MSQuery *query = [table queryWithPredicate: [NSPredicate predicateWithFormat:@"uID == %@", uID]];
        [query readWithCompletion:^(MSQueryResult *result, NSError *error) {
            if (error == nil)
            {
                for (NSDictionary *item in result.items)
                {
                    UserModel *data = [UserModel new];
                    data.id = [item objectForKey:@"id"];
                    data.placeID = [[item objectForKey:@"placeID"] intValue];
                    [favorites addObject:data];
                }
                complete(favorites);
            }
        }];
    }
    else
    {
        complete(favorites);
    }
}

static MSTable *table = nil;

+(void)updateFavorites:(int)attractionID dataID:(NSString*)dataID isadd:(BOOL)isadd complete:(void (^)(UserModel *user))complete
{
    if (isadd)
    {   //insert new
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setValue:uID forKey:@"uID"];
        [dict setValue:@(attractionID) forKey:@"placeID"];
        [table insert:dict completion:^(NSDictionary *item, NSError *error)
        {
            if (error == nil)
            {
                UserModel *data = [UserModel new];
                data.id = [item objectForKey:@"id"];
                data.placeID = attractionID;
                [favorites addObject:data];
                complete(data);
            }
        }];
    }
    else
    {   //delete
        [table deleteWithId:dataID completion:^(id itemId, NSError *error)
        {
            if (error == nil)
            {
                for (UserModel *user in favorites)
                {
                    if (user.id == dataID)
                    {   //remove
                        [favorites removeObject:user];
                        break;
                    }
                }
            }
        }];
    }
}

static NSString *uID = nil;

+(void)saveUser:(NSString*)userID
{
    uID = userID;
}
@end

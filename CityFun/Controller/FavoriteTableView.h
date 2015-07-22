//
//  FavoriteTableView.h
//  CityFun
//
//  Created by Shih-Ming Tung on 7/19/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttractionsModel.h"

@class FavoriteTableView;

@protocol FavoriteTableViewDelegate <NSObject>
@optional
- (void)FavoritePushView:(AttractionsModel*)attraction;
@end

@interface FavoriteTableView : UITableViewController
- (void)fetchData;
@property (weak, nonatomic) id<FavoriteTableViewDelegate> delegate;
@end

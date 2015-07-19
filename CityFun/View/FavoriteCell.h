//
//  FavoriteCell.h
//  CityFun
//
//  Created by Shih-Ming Tung on 7/19/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttractionsModel.h"

@interface FavoriteCell : UITableViewCell
@property (strong, nonatomic) AttractionsModel *place;
- (void)setUIData;
@end

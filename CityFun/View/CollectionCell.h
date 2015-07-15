//
//  CollectionCell.h
//  CityFun
//
//  Created by Shih-Ming Tung on 7/14/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttractionsModel.h"

@interface CollectionCell : UICollectionViewCell

@property (strong, nonatomic) AttractionsModel *attraction;
- (void)setUIData;
@end

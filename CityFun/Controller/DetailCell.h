//
//  DetailCell.h
//  CityFun
//
//  Created by Sean Zeng on 7/16/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTCollectionView.h"

@interface DetailCell : PSUICollectionViewCell

@property (strong, nonatomic) UILabel* label;
@property (strong, nonatomic) NSURL *photoURL;

@end

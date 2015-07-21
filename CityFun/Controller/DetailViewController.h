//
//  DetailViewController.h
//  CityFun
//
//  Created by Sean Zeng on 7/14/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttractionsModel.h"
#import "PSTCollectionView.h"

@interface DetailViewController : PSUICollectionViewController

@property (strong, nonatomic) AttractionsModel *attraction;

@end

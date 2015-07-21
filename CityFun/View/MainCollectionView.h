//
//  MainCollectionView.h
//  CityFun
//
//  Created by Shih-Ming Tung on 7/14/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttractionsModel.h"

@class MainCollectionView;

@protocol MainCollectionViewDelegate <NSObject>
@optional
- (void)CollectionPushView:(AttractionsModel*)attraction;
@end

@interface MainCollectionView : UIViewController
@property (weak, nonatomic) id<MainCollectionViewDelegate> delegate;
@end

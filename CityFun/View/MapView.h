//
//  MapView.h
//  CityFun
//
//  Created by Shih-Ming Tung on 7/14/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapView;

@protocol MapViewDelegate <NSObject>
@optional
- (void)MapView:(BOOL)didLoad;
@end

@interface MapView : UIViewController
@property (weak, nonatomic) id<MapViewDelegate> delegate;
@end

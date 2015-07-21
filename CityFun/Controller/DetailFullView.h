//
//  DetailFullView.h
//  CityFun
//
//  Created by Sean Zeng on 7/20/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttractionsModel.h"

@interface DetailFullView : UIView

@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *stitle;
@property (weak, nonatomic) IBOutlet UILabel *xbody;

@property (strong, nonatomic) AttractionsModel *attraction;

@end

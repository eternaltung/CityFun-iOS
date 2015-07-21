//
//  DetailView.h
//  CityFun
//
//  Created by Sean Zeng on 7/20/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttractionsModel.h"

@interface DetailView : UIView

@property (weak, nonatomic) IBOutlet UILabel *stitle;

@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;

@property (strong, nonatomic) AttractionsModel *attraction;

@end

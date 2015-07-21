//
//  DetailView.m
//  CityFun
//
//  Created by Sean Zeng on 7/20/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Custom setters

- (void)setAttraction:(AttractionsModel *)attraction {
    _attraction = attraction;
    
    self.stitle.text = attraction.stitle;
}

@end

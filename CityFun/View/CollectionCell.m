//
//  CollectionCell.m
//  CityFun
//
//  Created by Shih-Ming Tung on 7/14/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "CollectionCell.h"
#import <UIImageView+AFNetworking.h>

@interface CollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *PlaceImg;
@property (weak, nonatomic) IBOutlet UILabel *PlaceTitle;

@end

@implementation CollectionCell

- (void)awakeFromNib {
    
}

- (void)setUIData
{
    self.layer.cornerRadius = 5;
    
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.6;
    self.layer.shouldRasterize = YES;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.95];
    
    self.PlaceImg.image = nil;
    [self.PlaceImg setImageWithURL:[NSURL URLWithString:self.attraction.file]];
    self.PlaceTitle.text = self.attraction.stitle;
}

@end

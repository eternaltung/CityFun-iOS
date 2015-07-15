//
//  CollectionCell.m
//  CityFun
//
//  Created by Shih-Ming Tung on 7/14/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "CollectionCell.h"
#import <UIImageView+AFNetworking.h>
#import <POP.h>

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

- (void)setHighlighted:(BOOL)highlighted
{
    /*POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        //animation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.2)];
        //animation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.9, 0.9)];
    animation.springBounciness = 10;
        animation.velocity = @(1000);
        [self pop_addAnimation:animation forKey:@"springAnimation"];*/
    /*POPSpringAnimation *shake = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    shake.springBounciness = 20;
    shake.velocity = @(3000);
    [self pop_addAnimation:shake forKey:@"shake"];*/
    if (self.highlighted)
    {
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration = 0.1;
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
        [self pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
    else
    {
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        scaleAnimation.springBounciness = 20.f;
        [self pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
}

@end

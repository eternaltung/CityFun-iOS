//
//  FavoriteCell.m
//  CityFun
//
//  Created by Shih-Ming Tung on 7/19/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "FavoriteCell.h"
#import <UIImageView+AFNetworking.h>

@interface FavoriteCell()
@property (weak, nonatomic) IBOutlet UIImageView *PlaceImg;
@property (weak, nonatomic) IBOutlet UILabel *PlaceLabel;

@end

@implementation FavoriteCell

- (void)awakeFromNib {
    self.PlaceImg.clipsToBounds = YES;
    self.PlaceImg.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setUIData
{
    self.PlaceImg.image = nil;
    [self.PlaceImg setImageWithURL:[NSURL URLWithString:self.place.file]];
    self.PlaceLabel.text = self.place.stitle;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 5;
    frame.size.width -= 10;
    frame.size.height -= 5;
    [super setFrame:frame];
}

@end

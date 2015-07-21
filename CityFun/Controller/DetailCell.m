//
//  DetailCell.m
//  CityFun
//
//  Created by Sean Zeng on 7/16/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "DetailCell.h"
#import <UIImageView+AFNetworking.h>

@interface DetailCell ()

@end

@implementation DetailCell

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.contentView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.contentView.layer.borderWidth = 1;
    }
    return self;
}

#pragma mark - Custom setters

- (void)setPhotoURL:(NSURL *)photoURL {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:photoURL];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [UIView transitionWithView:imageView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve
            animations:^{
                CGRect newFrame = imageView.frame;
                //newFrame.size.width = image.size.width;
                //newFrame.size.height = image.size.height;
                imageView.frame = newFrame;
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                imageView.clipsToBounds = true;
                imageView.image = image;
                [self.contentView addSubview:imageView];
            }
            completion: nil
         ];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
    }];
}

@end

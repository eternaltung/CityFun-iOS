//
//  DetailFullView.m
//  CityFun
//
//  Created by Sean Zeng on 7/20/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "DetailFullView.h"
#import <UIImageView+AFNetworking.h>

@implementation DetailFullView

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
    
    self.address.text = attraction.address;
    self.info.text = attraction.info;
    self.stitle.text = attraction.stitle;
    self.xbody.text = attraction.xbody;
    
    NSURLRequest *imageRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.attraction.file]];
    [self.imageView setImageWithURLRequest:imageRequest placeholderImage:[UIImage imageNamed:@"avatarPlaceholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [UIView transitionWithView:self.imageView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve
                animations:^{
                    self.imageView.image = image;
                }
                completion: nil];
        }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            NSLog(@"%@", error);
        }
    ];
}

@end

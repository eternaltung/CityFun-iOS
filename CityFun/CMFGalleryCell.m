//
//  CMFGalleryCell.m
//  UICollectionGallery
//
//  Created by Tim on 09/04/2013.
//  Copyright (c) 2013 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMFGalleryCell.h"
#import "UIImageView+NSAdditions.h"

@interface CMFGalleryCell()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation CMFGalleryCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CMFGalleryCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
    }
    
    return self;
}

-(void)updateCell {
    [self.imageView fadeInImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.imageName]] placeholderImage:nil];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
}

@end

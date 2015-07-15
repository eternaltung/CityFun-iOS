//
//  UIImage+Resize.m
//  CityFun
//
//  Created by Shih-Ming Tung on 7/14/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)
//resize image
+ (UIImage *)image:(UIImage*)img resize:(CGSize)size
{
    //avoid redundant drawing
    if (CGSizeEqualToSize(img.size, size))
    {
        return img;
    }
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //draw
    [img drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}
@end

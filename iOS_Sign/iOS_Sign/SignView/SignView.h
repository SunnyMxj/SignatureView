//
//  SignView.h
//  iOS_Sign
//
//  Created by Ryan on 2019/2/28.
//  Copyright © 2019 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignView : UIView

@property (strong, nonatomic) UIColor *textColor;//字体颜色 default is [UIColor redColor]
@property (assign, nonatomic) CGFloat lineWidth;//字体粗细 default is 3.f

/**
 清除画板
 */
- (void)clear;

/**
 获取当前签名

 @return 签名的image
 */
- (UIImage *)getSignImage;

@end

//
//  SignView.m
//  iOS_Sign
//
//  Created by Ryan on 2019/2/28.
//  Copyright © 2019 Ryan. All rights reserved.
//

#import "SignView.h"

@interface SignView () {
    CGPoint points[5];
}

@property (assign, nonatomic) NSInteger pointIndex;
@property (strong, nonatomic) UIBezierPath *bezierPath;

@end

@implementation SignView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    [self setMultipleTouchEnabled:NO];
    
    _textColor = [UIColor redColor];
    _lineWidth = 3.f;
    _bezierPath = [UIBezierPath bezierPath];
    [_bezierPath setLineWidth:_lineWidth];
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    [_bezierPath setLineWidth:_lineWidth];
}

#pragma mark -- core
- (void)drawRect:(CGRect)rect {
    [_textColor setStroke];
    [_bezierPath stroke];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _pointIndex = 0;
    UITouch *touch = touches.anyObject;
    points[_pointIndex] = [touch locationInView:self];
    [_bezierPath moveToPoint:points[0]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _pointIndex++;
    UITouch *touch = touches.anyObject;
    points[_pointIndex] = [touch locationInView:self];
    if (_pointIndex == 4) {
        points[3] = CGPointMake((points[2].x + points[4].x)/2, (points[2].y + points[4].y)/2);
        [_bezierPath moveToPoint:points[0]];
        [_bezierPath addCurveToPoint:points[3] controlPoint1:points[1] controlPoint2:points[2]];
        [self setNeedsDisplay];
        
        //reset new start to last end
        points[0] = points[3];
        points[1] = points[4];
        _pointIndex = 1;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_pointIndex < 4) {
        _pointIndex++;
        UITouch *touch = touches.anyObject;
        points[_pointIndex] = [touch locationInView:self];
        CGPoint to = points[_pointIndex];
        CGPoint center = CGPointZero;
        CGPoint from = CGPointZero;
        if (_pointIndex > 1) {
            center = points[_pointIndex-1];
            from = points[_pointIndex-2];
        } else {
            from = points[_pointIndex-1];
        }
        if (CGPointEqualToPoint(to, from)) {
            [_bezierPath addQuadCurveToPoint:CGPointMake(to.x + 2, to.y + 2) controlPoint:from];
            //圆点
//            [_bezierPath addArcWithCenter:from radius:1.f startAngle:0 endAngle:M_PI*2 clockwise:YES];
        } else if (CGPointEqualToPoint(center, CGPointZero)) {
            [_bezierPath addQuadCurveToPoint:to controlPoint:from];
        } else {
            [_bezierPath addCurveToPoint:to controlPoint1:from controlPoint2:center];
        }
        [self setNeedsDisplay];
    }
}


#pragma mark -- method
- (void)clear {
    [self.bezierPath removeAllPoints];
    [self setNeedsDisplay];
}

- (UIImage *)getSignImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *signImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return signImage;
}

@end

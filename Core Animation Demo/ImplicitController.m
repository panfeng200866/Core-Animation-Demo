//
//  ImplicitController.m
//  Core Animation
//
//  Created by Sammer on 15/7/5.
//  Copyright (c) 2015年 Pan. All rights reserved.
//

#import "ImplicitController.h"

@interface ImplicitController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIView *layerView2;

@property (strong, nonatomic) CALayer *colorLayer;
@property (strong, nonatomic) UIView *subLayerView2;

@end

@implementation ImplicitController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 50, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
    
    self.subLayerView2 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    self.subLayerView2.backgroundColor = [UIColor blueColor];
    [self.layerView2 addSubview:self.subLayerView2];
}

- (IBAction)changecolor:(id)sender
{
    //Core Animation在每个run loop周期中自动开始一次新的事务，不用显式的调用[CATransaction begin]开始一次事务，任何在一次run loop循环中属性的改变都会被集中起来，默认调用+setAnimationDuration:方法设置当前事务的动画时间（0.25s）然后做一次动画
    //    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    //    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    //    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    //    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f].CGColor;
    
    //开启一个新的事务
    //    [CATransaction begin];
    //    [CATransaction setDisableActions:YES];
    //    [CATransaction setAnimationDuration:1.0f];
    //    [CATransaction setCompletionBlock:^{
    CGAffineTransform transform = self.colorLayer.affineTransform;
    transform = CGAffineTransformRotate(transform, M_PI_2);
    self.colorLayer.affineTransform = transform;
    //    }];
    //    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    //    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    //    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    //    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f].CGColor;
    //    [CATransaction commit];
}

- (IBAction)changecolor2:(id)sender
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0f];
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.subLayerView2.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f].CGColor;
    [CATransaction commit];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    CGPoint point = [[touches anyObject] locationInView:self.layerView];
    //    if ([self.colorLayer.presentationLayer hitTest:point]) {
    //        CGFloat red = arc4random() / (CGFloat)INT_MAX;
    //        CGFloat green = arc4random() / (CGFloat)INT_MAX;
    //        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    //        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f].CGColor;
    //    }
    //    else {
    //        [CATransaction begin];
    //        [CATransaction setAnimationDuration:4.0f];
    //        self.colorLayer.position = point;
    //        [CATransaction commit];
    //    }
}

@end







//
//  BasicAnimationController.m
//  Core Animation
//
//  Created by Sammer on 15/7/5.
//  Copyright (c) 2015年 Pan. All rights reserved.
//

#import "BasicAnimationController.h"

@interface BasicAnimationController ()

@property (weak, nonatomic) IBOutlet UIView *baseView;


@end

@implementation BasicAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scale:(id)sender {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.fromValue = @(1.0);
    anim.toValue = @(0.5);
    anim.duration = 0.5f;
    
    [self.baseView.layer addAnimation:anim forKey:nil];
}

- (IBAction)rotate:(id)sender {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"]; //默认是z
    anim.toValue = @(M_PI_2 / 2);
    anim.duration = 0.5f;
    [self.baseView.layer addAnimation:anim forKey:nil];
}

- (IBAction)changecolor:(id)sender {
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.duration = 0.5f;
    animation.toValue = (__bridge id)color.CGColor;
    animation.delegate = self;
    [self.baseView.layer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.baseView.layer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}


@end






//
//  TickViewController.m
//  Core Animation
//
//  Created by Sammer on 15/7/5.
//  Copyright (c) 2015年 Pan. All rights reserved.
//

#import "TickViewController.h"

@interface TickViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *tickView;
@property (strong, nonatomic) UIView *hourView;
@property (strong, nonatomic) UIView *minView;
@property (nonatomic, strong) UIView *secView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hourView.center = self.tickView.center;
    self.hourView.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.minView.center = self.tickView.center;
    self.minView.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.secView.center = self.tickView.center;
    self.secView.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [self updateHandsAnimated:NO];
}

- (void)tick
{
    [self updateHandsAnimated:YES];
}

- (void)updateHandsAnimated:(BOOL)animated
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hourAngle = (components.hour / 12.0) * M_PI * 2.0;
    CGFloat minuteAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secondAngle = (components.second / 60.0) * M_PI * 2.0;
    
    [self setAngle:hourAngle forHand:self.hourView animated:animated];
    [self setAngle:minuteAngle forHand:self.minView animated:animated];
    [self setAngle:secondAngle forHand:self.secView animated:animated];
}

- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView animated:(BOOL)animated
{
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animation];
        [self updateHandsAnimated:NO];
        animation.keyPath = @"transform";
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.duration = 0.5;
        animation.delegate = self;
        [animation setValue:handView forKey:@"handView"];
        [handView.layer addAnimation:animation forKey:nil];
    } else {
        handView.layer.transform = transform;
    }
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    UIView *handView = [anim valueForKey:@"handView"];
    handView.layer.transform = [anim.toValue CATransform3DValue];
}

- (UIView *)hourView
{
    if (!_hourView) {
        _hourView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 9, 70)];
        _hourView.backgroundColor = [UIColor darkGrayColor];
        [self.view addSubview:_hourView];
    }
    return _hourView;
}

- (UIView *)minView
{
    if (!_minView) {
        _minView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 80)];
        _minView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:_minView];
    }
    return _minView;
}

- (UIView *)secView
{
    if (!_secView) {
        _secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 88)];
        _secView.layer.masksToBounds = YES;
        _secView.layer.cornerRadius = 2.0f;
        _secView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_secView];
    }
    return _secView;
    
}



@end






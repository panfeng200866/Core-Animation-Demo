//
//  KeyFrameViewController.m
//  Core Animation
//
//  Created by Sammer on 15/7/5.
//  Copyright (c) 2015年 Pan. All rights reserved.
//

#import "KeyFrameViewController.h"

@interface KeyFrameViewController ()

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIImageView *people;
@property (weak, nonatomic) IBOutlet UIView *view2;


@property (weak, nonatomic) IBOutlet UISlider *durationSlider;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UISlider *timeOffsetSlider;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UILabel *timeOffsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

@end

@implementation KeyFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(20, 75)];
    [bezierPath addCurveToPoint:CGPointMake(200, 75) controlPoint1:CGPointMake(80, 0) controlPoint2:CGPointMake(150, 150)];
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view2.layer addSublayer:pathLayer];
    
    
    NSMutableArray *peopleImages = [NSMutableArray array];
    [peopleImages addObject:[UIImage imageNamed:@"stop"]];
    [peopleImages addObject:[UIImage imageNamed:@"walk"]];
    
    self.people.animationImages = peopleImages;
    self.people.animationDuration = 0.4f;
    self.people.animationRepeatCount = 0;
    self.people.center = CGPointMake(20, 75);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeColor:(id)sender
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = self.durationSlider.value;
    animation.timeOffset = self.timeOffsetSlider.value;
    animation.speed = self.speedSlider.value;
    animation.values = @[
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
    animation.delegate = self;
    [animation setValue:self.view1 forKey:@"colorView"];
    [self.view1.layer addAnimation:animation forKey:nil];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    UIView *colorView = [anim valueForKey:@"colorView"];
    if (colorView) {
        colorView.backgroundColor = [UIColor blueColor];
    }
    
    UIImageView *people = [anim valueForKey:@"people"];
    if (people) {
        [people stopAnimating];
        people.center = CGPointMake(200, 75);
    }
}

- (IBAction)walk:(id)sender
{
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(20, 75)];
    [bezierPath addCurveToPoint:CGPointMake(200, 75) controlPoint1:CGPointMake(80, 0) controlPoint2:CGPointMake(150, 150)];
    
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.path = bezierPath.CGPath;
    animation.delegate = self;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.duration = self.durationSlider.value;
    animation.timeOffset = self.timeOffsetSlider.value;
    animation.speed = self.speedSlider.value;
    animation.timeOffset = 1;
    [animation setValue:self.people forKey:@"people"];
    [self.people.layer addAnimation:animation forKey:nil];
    
    [self.people startAnimating];
}

- (IBAction)pause:(id)sender
{
    CFTimeInterval pauseTime = [self.people.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    [self.people.layer setTimeOffset:pauseTime];
    self.people.layer.speed = 0;
}

- (IBAction)resume:(id)sender
{
    CFTimeInterval pauseTime = self.people.layer.timeOffset;
    CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
    
    self.people.layer.timeOffset = 0;
    self.people.layer.beginTime = beginTime;
    self.people.layer.speed = 1;
}

- (IBAction)timeOffsetChanged:(id)sender
{
    UISlider *timeOffsetSlider = (UISlider *)sender;
    self.timeOffsetLabel.text = [NSString stringWithFormat:@"%.1f",timeOffsetSlider.value];
}

- (IBAction)speedChanged:(id)sender
{
    UISlider *speedSlider = (UISlider *)sender;
    self.speedLabel.text = [NSString stringWithFormat:@"%.1f",speedSlider.value];
}

- (IBAction)durationChanged:(id)sender
{
    UISlider *durationSlider = (UISlider *)sender;
    self.durationLabel.text = [NSString stringWithFormat:@"%.1f",durationSlider.value];
}

@end








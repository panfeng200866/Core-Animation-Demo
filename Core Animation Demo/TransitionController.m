//
//  TransitionController.m
//  Core Animation
//
//  Created by Sammer on 15/7/5.
//  Copyright (c) 2015年 Pan. All rights reserved.
//

#import "TransitionController.h"

@interface TransitionController ()

@property (nonatomic, strong) NSMutableArray *imageList;

@end

@implementation TransitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"guide_bg_1"];
    [self.view addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [imageView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    [imageView addGestureRecognizer:swiperight];
    
    self.imageList = [NSMutableArray arrayWithCapacity:4];
    for (NSInteger i=0; i<4; i++) {
        NSString *fileName = [NSString stringWithFormat:@"guide_bg_%ld",i+1];
        UIImage *image = [UIImage imageNamed:fileName];
        [self.imageList addObject:image];
    }
}

- (void)swipe:(UISwipeGestureRecognizer *)gesture
{
    UIImageView *imageView = (UIImageView *)gesture.view;
    
    CATransition *transition = [[CATransition alloc] init];
    transition.type = @"suckEffect";
    //    transition.type = kCATransitionMoveIn;
    transition.duration = 0.4;
    
    if (UISwipeGestureRecognizerDirectionLeft == gesture.direction) {
        transition.subtype = kCATransitionFromRight;
        imageView.tag = (imageView.tag + 1) % self.imageList.count;
    } else {
        transition.subtype = kCATransitionFromLeft;
        imageView.tag = (imageView.tag - 1 + self.imageList.count) % self.imageList.count;
    }
    
    imageView.image = self.imageList[imageView.tag];
    
    [gesture.view.layer addAnimation:transition forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

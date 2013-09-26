//
//  DTShakeViewController.m
//  DynamicsExamples
//
//  Created by Diogo Tridapalli on 9/25/13.
//  Copyright (c) 2013 Diogo Tridapalli. All rights reserved.
//

#import "DTShakeViewController.h"

@interface DTShakeViewController ()

@property (nonatomic, strong) UIPushBehavior *push;
@property (nonatomic, strong) UIAttachmentBehavior *constraint;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIView *shakingView;

@end

@implementation DTShakeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];


    UIView *shakingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    shakingView.center = self.view.center;
    shakingView.backgroundColor = [UIColor redColor];
    [self.view addSubview:shakingView];
    self.shakingView = shakingView;

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    UIAttachmentBehavior *constraint;
    constraint = [[UIAttachmentBehavior alloc] initWithItem:shakingView
                                           attachedToAnchor:self.view.center];
    constraint.damping = 0.1;
    constraint.frequency = 5;

    self.constraint = constraint;

    UIPushBehavior *push;
    push = [[UIPushBehavior alloc] initWithItems:@[shakingView]
                                            mode:UIPushBehaviorModeInstantaneous];
    [push setAngle:0 magnitude:-8];

    self.push = push;

    UITapGestureRecognizer *gesture;
    gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(shake)];
    [shakingView addGestureRecognizer:gesture];
}

- (void)shake
{
    [self.animator addBehavior:self.constraint];
    [self.animator addBehavior:self.push];
    self.push.active = YES;

    [self performSelector:@selector(stopShaking)
               withObject:self
               afterDelay:1.0];
}

- (void)stopShaking
{
    [self.animator removeAllBehaviors];
    self.shakingView.center = self.view.center;
    [self.animator updateItemUsingCurrentState:self.shakingView];
}

@end

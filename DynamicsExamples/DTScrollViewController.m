//
//  DTScrollViewController.m
//  DynamicsExamples
//
//  Created by Diogo Tridapalli on 9/25/13.
//  Copyright (c) 2013 Diogo Tridapalli. All rights reserved.
//

#import "DTScrollViewController.h"
#import "DTDynamicItem.h"


typedef NS_ENUM(NSInteger, DTGravityDirection){
    DTGravityUp = 0,
    DTGravityDown
};

@interface DTScrollViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) DTDynamicItem *item;

@end

@implementation DTScrollViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;

    self.view.backgroundColor = [UIColor whiteColor];
    CGRect frame = self.view.bounds;

    UIImage *image = [UIImage imageNamed:@"img.jpg"];
    UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:image];
    backgroundImg.opaque = YES;
    backgroundImg.contentMode = UIViewContentModeScaleAspectFill;
    backgroundImg.frame = frame;
    [self.view addSubview:backgroundImg];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(frame), 2*CGRectGetHeight(frame));
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    scrollView.delegate = self;
    self.scrollView = scrollView;

    UIImage *image2 = [[UIImage imageNamed:@"camera"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *cameraImg = [UIButton buttonWithType:UIButtonTypeSystem];
    [cameraImg setImage:image2 forState:UIControlStateNormal];

    CGFloat tapSize = 60;
    cameraImg.frame = CGRectMake(CGRectGetWidth(frame) - tapSize,
                                 CGRectGetHeight(frame) - tapSize,
                                 tapSize, tapSize);
    CGFloat height = 24;
    CGFloat width = 32;
    CGFloat inset = 8;
    cameraImg.imageEdgeInsets = UIEdgeInsetsMake(tapSize - height - inset,
                                                 tapSize - width - inset,
                                                 inset,
                                                 inset);


    [cameraImg addTarget:self
                  action:@selector(cameraTap)
        forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:cameraImg];

    CGRect backgroundFrame = CGRectOffset(frame, 0, CGRectGetHeight(frame));
    UIView *backgroudView = [[UIView alloc] initWithFrame:backgroundFrame];
    backgroudView.backgroundColor = [UIColor blackColor];
    [scrollView addSubview:backgroudView];

    self.item = [[DTDynamicItem alloc] initWithScrollView:self.scrollView];
}


#pragma mark animations

- (void)cameraTap
{
    [self enableGravity:DTGravityDown];
    [self addSpeed:400];
}

- (void)enableGravity:(DTGravityDirection)direction
{
    CGFloat yBorder = 0;
    CGFloat gravitySignal = -1;
    if (direction == DTGravityUp) {
        yBorder = -CGRectGetHeight(self.view.frame);
        gravitySignal = 1;
    }

    DTDynamicItem *item = self.item;

    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;

    UICollisionBehavior *border = [[UICollisionBehavior alloc] initWithItems:@[item]];
    [border addBoundaryWithIdentifier:@"border"
                            fromPoint:CGPointMake(0, yBorder)
                              toPoint:CGPointMake(CGRectGetWidth(self.view.frame), yBorder)];
    border.collisionMode = UICollisionBehaviorModeBoundaries;
    [animator addBehavior:border];

    UIDynamicItemBehavior *bouce = [[UIDynamicItemBehavior alloc] initWithItems:@[item]];
    bouce.allowsRotation = NO;
    bouce.elasticity = 0.4;
    [animator addBehavior:bouce];

    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[item]];
    gravity.gravityDirection = CGVectorMake(0, 2*gravitySignal);
    [animator addBehavior:gravity];
}

- (void)addSpeed:(CGFloat)magnitude
{
    UIDynamicItemBehavior *speed = [[UIDynamicItemBehavior alloc] initWithItems:@[self.item]];
    [speed addLinearVelocity:CGPointMake(0, magnitude)
                     forItem:self.item];
    [self.animator addBehavior:speed];
}

- (void)stopAnimations
{
    if (self.animator) {
        [self.animator removeAllBehaviors];
        self.animator = nil;
    }
}


#pragma mark - ScrollView delegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat height = scrollView.contentSize.height;
    CGFloat offset = targetContentOffset->y / height;

    if (offset > 0.27) {
        [self enableGravity:DTGravityUp];
    } else {
        [self enableGravity:DTGravityDown];
    }
    [self addSpeed:velocity.y*380];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopAnimations];
}

#pragma mark - DynamicAnimator delegate

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    [self stopAnimations];
}

@end

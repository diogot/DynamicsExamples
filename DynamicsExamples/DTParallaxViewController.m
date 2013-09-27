//
//  DTParallaxViewController.m
//  DynamicsExamples
//
//  Created by Diogo Tridapalli on 9/24/13.
//  Copyright (c) 2013 Diogo Tridapalli. All rights reserved.
//

#import "DTParallaxViewController.h"

@interface DTParallaxViewController ()

@property (nonatomic, strong) UIImageView *image;

@end

@implementation DTParallaxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    UIImage *img = [UIImage imageNamed:@"img.jpg"];
    self.image = [[UIImageView alloc] initWithImage:img];
    self.image.opaque = YES;
    self.image.contentMode = UIViewContentModeScaleAspectFill;
    self.image.frame = self.view.bounds;

    [self.view addSubview:self.image];

    NSInteger range = 50;

    UIInterpolatingMotionEffectType horizontal = UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis;
    UIInterpolatingMotionEffect *horizontalAxix;
    horizontalAxix = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                     type:horizontal];
    horizontalAxix.minimumRelativeValue = @(range);
    horizontalAxix.maximumRelativeValue = @(-range);

    UIInterpolatingMotionEffectType vertical = UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis;
    UIInterpolatingMotionEffect *verticalAxix;
    verticalAxix = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                   type:vertical];
    verticalAxix.minimumRelativeValue = @(range);
    verticalAxix.maximumRelativeValue = @(-range);

    UIMotionEffectGroup *parallax = [[UIMotionEffectGroup alloc] init];
    parallax.motionEffects = @[horizontalAxix, verticalAxix];

    [self.image addMotionEffect:parallax];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSTimeInterval duration = animated ? 0.2 : 0.0;

    [UIView animateWithDuration:duration
                     animations:^{
                         self.image.alpha = 0.0;
                     }];
}

@end

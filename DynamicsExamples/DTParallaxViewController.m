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

    NSNumber *relativeMin = @-50;
    NSNumber *relativeMax = @50;

    UIInterpolatingMotionEffect *interpolationHorizontal = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    interpolationHorizontal.minimumRelativeValue = relativeMin;
    interpolationHorizontal.maximumRelativeValue = relativeMax;

    UIInterpolatingMotionEffect *interpolationVertical = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    interpolationVertical.minimumRelativeValue = relativeMin;
    interpolationVertical.maximumRelativeValue = relativeMax;

    UIMotionEffectGroup *parallax = [[UIMotionEffectGroup alloc] init];
    parallax.motionEffects = @[interpolationHorizontal, interpolationVertical];

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

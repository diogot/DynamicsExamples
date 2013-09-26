//
//  DTDynamicItem.m
//  DynamicsExamples
//
//  Created by Diogo Tridapalli on 9/26/13.
//  Copyright (c) 2013 Diogo Tridapalli. All rights reserved.
//

#import "DTDynamicItem.h"

@interface DTDynamicItem ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation DTDynamicItem

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    self = [super init];
    if (self) {
        _scrollView = scrollView;
    }
    return self;
}

- (CGRect)bounds
{
    CGRect bounds = CGRectMake(0, 0, 0, 0);
    bounds.size = _scrollView.bounds.size;

    return bounds;
}

- (CGPoint)center
{
    CGRect frame;
    frame.origin = _scrollView.contentOffset;
    frame.size = _scrollView.bounds.size;

    CGPoint center = CGPointMake(CGRectGetMidX(frame),
                                 CGRectGetMidY(frame));

    return center;
}

- (void)setCenter:(CGPoint)center
{
    CGRect frame = CGRectMake(0, 0, 0, 0);
    frame.size = _scrollView.bounds.size;

    CGFloat x = center.x - CGRectGetMidX(frame);
    CGFloat y = center.y - CGRectGetMidY(frame);

    frame.origin = CGPointMake(x, y);

    [_scrollView scrollRectToVisible:frame animated:NO];
}


@end

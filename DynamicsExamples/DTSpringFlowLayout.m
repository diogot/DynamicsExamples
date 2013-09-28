//
//  DTSpringFlowLayout.m
//  DynamicsExamples
//
//  Created by Diogo Tridapalli on 9/25/13.
//  Copyright (c) 2013 Diogo Tridapalli. All rights reserved.
//

#import "DTSpringFlowLayout.h"

@interface DTSpringFlowLayout ()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end


@implementation DTSpringFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];

    if (self.animator == nil) {
        self.animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];

        CGSize contenSize = [self collectionViewContentSize];
        CGRect rect = CGRectMake(0, 0, contenSize.width, contenSize.height);
        NSArray *items = [super layoutAttributesForElementsInRect:rect];

        for (UICollectionViewLayoutAttributes *item in items) {
            UIAttachmentBehavior *spring;
            spring = [[UIAttachmentBehavior alloc] initWithItem:item
                                               attachedToAnchor:item.center];

            spring.length = 0.0;
            spring.damping = 0.5;
            spring.frequency = 0.8;

            [self.animator addBehavior:spring];
        }
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.animator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.animator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrollDelta = CGRectGetMinY(newBounds) - CGRectGetMinY(scrollView.bounds);
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];

    for (UIAttachmentBehavior *spring in [self.animator behaviors]) {
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanceFromTouch = fabsf(touchLocation.y - anchorPoint.y);
        CGFloat scrollResistence = distanceFromTouch / 500;

        UICollectionViewLayoutAttributes *item = [spring.items firstObject];
        CGPoint center = item.center;
        center.y += scrollDelta * MIN(scrollResistence, 1);
        item.center = center;

        [self.animator updateItemUsingCurrentState:item];
    }
    
    return NO;
}

@end
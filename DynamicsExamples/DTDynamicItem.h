//
//  DTDynamicItem.h
//  DynamicsExamples
//
//  Created by Diogo Tridapalli on 9/26/13.
//  Copyright (c) 2013 Diogo Tridapalli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTDynamicItem : NSObject <UIDynamicItem>

@property (nonatomic, readonly) CGRect bounds;
@property (nonatomic, readwrite) CGPoint center;
@property (nonatomic, readwrite) CGAffineTransform transform;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

@end

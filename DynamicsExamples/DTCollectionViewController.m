//
//  DTCollectionViewController.m
//  DynamicsExamples
//
//  Created by Diogo Tridapalli on 9/25/13.
//  Copyright (c) 2013 Diogo Tridapalli. All rights reserved.
//

#import "DTCollectionViewController.h"
#import "DTSpringFlowLayout.h"

static NSString * const CellIdentifier = @"Cell";

@implementation DTCollectionViewController

- (id)init
{
    DTSpringFlowLayout *layout = [[DTSpringFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:CellIdentifier];
}

#pragma mark - CollectionView data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 80;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                     forIndexPath:indexPath];

    cell.backgroundColor = [UIColor grayColor];

    return cell;
}


@end

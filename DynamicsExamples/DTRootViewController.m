//
//  DTRootViewController.m
//  DynamicsExamples
//
//  Created by Diogo Tridapalli on 9/24/13.
//  Copyright (c) 2013 Diogo Tridapalli. All rights reserved.
//

#import "DTRootViewController.h"
#import "DTParallaxViewController.h"
#import "DTShakeViewController.h"
#import "DTCollectionViewController.h"
#import "DTScrollViewController.h"

NS_ENUM(NSInteger, DTDynamicsType) {
    DTDynamicsTypeWrongPassword = 0,
    DTDynamicsTypeScrollView,
    DTDynamicsTypeCollectionView,
    DTDynamicsTypeParallax,
    DTDynamicsTypes
};

static NSString * const CellIdentifier = @"Cell";

@interface DTRootViewController ()

@end

@implementation DTRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Dynamics example", @"Dynamics example");

    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:CellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return DTDynamicsTypes;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSString *name;

    switch (indexPath.row) {
        case DTDynamicsTypeParallax:
            name = NSLocalizedString(@"Parallax", @"Parallax");
            break;
        case DTDynamicsTypeCollectionView:
            name = NSLocalizedString(@"CollectionView", @"CollectionView");
            break;
        case DTDynamicsTypeScrollView:
            name = NSLocalizedString(@"ScrollView", @"ScrollView");
            break;
        case DTDynamicsTypeWrongPassword:
            name = NSLocalizedString(@"Wrong password", @"Wrong password");
            break;
        default:
            name = NSLocalizedString(@"none", @"none");
            break;
    }

    cell.textLabel.text = name;

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case DTDynamicsTypeParallax:
            [self pushParallaxController];
            break;
        case DTDynamicsTypeCollectionView:
            [self pushCollectionController];
            break;
        case DTDynamicsTypeScrollView:
            [self pushScrollController];
            break;
        case DTDynamicsTypeWrongPassword:
            [self pushShakeController];
            break;
        default:
            NSLog(@"none");
            break;
    }
}

- (void)pushParallaxController
{
    DTParallaxViewController *controller = [[DTParallaxViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)pushShakeController
{
    DTShakeViewController *controller = [[DTShakeViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)pushCollectionController
{
    DTCollectionViewController *controller = [[DTCollectionViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)pushScrollController
{
    DTScrollViewController *controller = [[DTScrollViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end

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


NS_ENUM(NSInteger, DTDynamicsType) {
    DTDynamicsTypeParallax = 0,
    DTDynamicsTypeScrollView,
    DTDynamicsTypeLockScreen,
    DTDynamicsTypeWrongPassword,
    DTDynamicsTypes
};

@interface DTRootViewController ()

@end

@implementation DTRootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Dynamics example", @"Dynamics example");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return DTDynamicsTypes;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSString *name;

    switch (indexPath.row) {
        case DTDynamicsTypeParallax:
            name = NSLocalizedString(@"Parallax", @"Parallax");
            break;
        case DTDynamicsTypeCollectionView:
            name = NSLocalizedString(@"CollectionView", @"CollectionView");
            break;
        case DTDynamicsTypeLockScreen:
            name = NSLocalizedString(@"LockScreen", @"LockScreen");
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
        case DTDynamicsTypeLockScreen:
            NSLog(@"lock");
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


@end

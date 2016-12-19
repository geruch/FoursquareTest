//
//  FTLocationsListWireframe.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 19.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTLocationsListWireframe.h"
#import "FTLocationsListModuleVC.h"
#import "FTLocationsListPresenter.h"

static NSString *LocationsViewControllerIdentifier = @"FTLocationsListModule";

@interface FTLocationsListWireframe ()

@property (nonatomic, strong) FTLocationsListModuleVC *locationsViewController;

@end

@implementation FTLocationsListWireframe

- (void)pushLocationsToNavigationController:(UINavigationController *)navigationController
{
    UIViewController *viewController = [self configuredViewController];
    [navigationController pushViewController:viewController animated:YES];
}

- (UIViewController *)configuredViewController
{
    FTLocationsListModuleVC *locationsViewController = [self locationsViewControllerFromStoryboard];
    locationsViewController.eventHandler = self.locationsPresenter;
    self.locationsPresenter.userInterface = locationsViewController;
    self.locationsViewController = locationsViewController;
    
    return locationsViewController;
}

- (UIStoryboard *)actualStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:LocationsViewControllerIdentifier bundle:[NSBundle mainBundle]];
    
    return storyboard;
}

- (FTLocationsListModuleVC *)locationsViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self actualStoryboard];
    FTLocationsListModuleVC *viewController = [storyboard instantiateViewControllerWithIdentifier:LocationsViewControllerIdentifier];
    
    return viewController;
}

#pragma mark - module interface

-(void)dismissLocations
{
//    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

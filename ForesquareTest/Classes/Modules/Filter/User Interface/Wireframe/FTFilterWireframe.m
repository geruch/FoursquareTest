//
//  FTFilterWireframe.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 16.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTFilterWireframe.h"
#import "FTFilterModuleViewController.h"
#import "FTFilterPresenter.h"

static NSString *FilterViewControllerIdentifier = @"FTFilterModuleViewController";

@interface FTFilterWireframe ()

@property (nonatomic, strong) UIViewController *presentedViewController;
@property (nonatomic, strong) FTFilterModuleViewController *filterViewController;

@end

@implementation FTFilterWireframe

- (void)presentFilterFromViewController:(UIViewController *)viewController
{
    FTFilterModuleViewController *filterViewController = [self filterViewControllerFromStoryboard];
    filterViewController.eventHandler = self.filterPresenter;
    filterViewController.modalPresentationStyle = UIModalPresentationCustom;
    filterViewController.transitioningDelegate = self;
    
    
    [viewController presentViewController:filterViewController animated:YES completion:nil];
    self.presentedViewController = viewController;
}

- (void)pushFilterToNavigationController:(UINavigationController *)navigationController
{
    UIViewController *viewController = [self configuredViewController];
    [navigationController pushViewController:viewController animated:YES];
}

- (UIViewController *)configuredViewController
{
    FTFilterModuleViewController *filterViewController = [self filterViewControllerFromStoryboard];
    filterViewController.eventHandler = self.filterPresenter;
    self.filterPresenter.userInterface = filterViewController;
    self.filterViewController = filterViewController;
    
    return filterViewController;
}

- (UIStoryboard *)actualStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:FilterViewControllerIdentifier bundle:[NSBundle mainBundle]];
    
    return storyboard;
}

- (FTFilterModuleViewController *)filterViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self actualStoryboard];
    FTFilterModuleViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:FilterViewControllerIdentifier];
    
    return viewController;
}

#pragma mark - module interface

-(void)dismissFilter
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

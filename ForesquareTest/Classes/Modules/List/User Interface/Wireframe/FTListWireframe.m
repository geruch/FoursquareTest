//
//  FTListWireframe.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 14.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTListWireframe.h"
#import "FTListModuleViewController.h"
#import "FTListPresenter.h"

static NSString *ListViewControllerIdentifier = @"FTListViewController";
static NSString *ListViewControllerStoryboardName = @"FTListView";

@interface FTListWireframe ()

@property (nonatomic, strong) FTListModuleViewController *listViewController;

@end

@implementation FTListWireframe

- (void)presentListInterfaceFromWindow:(UIWindow *)window
{
    FTListModuleViewController *listViewController = [self listViewControllerFromStoryboard];
    listViewController.eventHandler = self.listPresenter;
    self.listPresenter.userInterface = listViewController;
    self.listViewController = listViewController;
    
    [self.rootWireframe showRootViewController:listViewController
                                      inWindow:window];
}

- (UIViewController *)configuredViewController
{
    FTListModuleViewController *viewController = [self listViewControllerFromStoryboard];
    viewController.eventHandler = self.listPresenter;
    self.listPresenter.userInterface = viewController;
    self.listViewController = viewController;
    return viewController;
}

- (FTListModuleViewController *)listViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self actualStoryboard];
    FTListModuleViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:ListViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)actualStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:ListViewControllerStoryboardName bundle:[NSBundle mainBundle]];
    
    return storyboard;
}


- (void)showFilterScreen
{
//    [self.filterWireframe presentFilterFromViewController:self.listViewController];
    [self.filterWireframe pushFilterToNavigationController:self.listViewController.navigationController];
}

- (void)showLocationsScreen
{
    [self.locationsWireframe pushLocationsToNavigationController:self.listViewController.navigationController];
}

@end

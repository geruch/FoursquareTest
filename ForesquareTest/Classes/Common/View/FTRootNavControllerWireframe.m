//
//  FTRootNavControllerWireframe.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 16.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//


#import "FTRootNavControllerWireframe.h"

static NSString *NavViewControllerIdentifier = @"RootNavViewController";
static NSString *NavViewControllerStoryboardName = @"FTNavViewController";

@implementation FTRootNavControllerWireframe

- (void)showRootViewController:(UIViewController *)viewController
                      inWindow:(UIWindow *)window
{
    UINavigationController *navigationController = [self navigationControllerFromWindow:window];
    navigationController.viewControllers = @[viewController];
}

- (UINavigationController *)navigationControllerFromWindow:(UIWindow *)window
{
    UINavigationController *navigationController = (UINavigationController *)[window rootViewController];
    
    return navigationController;
}

- (UINavigationController *)navControllerFromStoryboard
{
    UIStoryboard *storyboard = [self actualStoryboard];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:NavViewControllerIdentifier];
    
    return navigationController;
}

- (UIStoryboard *)actualStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NavViewControllerStoryboardName bundle:[NSBundle mainBundle]];
    
    return storyboard;
}

@end

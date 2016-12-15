//
//  FTRootNavControllerWireframe.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 16.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FTRootNavControllerWireframe : NSObject

- (void)showRootViewController:(UIViewController *)viewController
                      inWindow:(UIWindow *)window;
- (UINavigationController *)navigationControllerFromWindow:(UIWindow *)window;

@end

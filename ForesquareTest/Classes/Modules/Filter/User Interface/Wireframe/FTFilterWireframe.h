//
//  FTFilterWireframe.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 16.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FTFilterPresenter;

@interface FTFilterWireframe : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) FTFilterPresenter *filterPresenter;

-(void)dismissFilter;
-(void)presentFilterFromViewController:(UIViewController *)viewController;

@end

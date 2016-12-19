//
//  FTLocationsListWireframe.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 19.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FTLocationsListPresenter;

@interface FTLocationsListWireframe : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) FTLocationsListPresenter *locationsPresenter;

-(void)dismissLocations;
-(void)pushLocationsToNavigationController:(UINavigationController *)navigationController;

@end

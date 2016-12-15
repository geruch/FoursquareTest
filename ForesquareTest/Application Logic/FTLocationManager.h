//
//  FTLocationManager.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 12.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FTLocationManagerInterface.h"

@interface FTLocationManager : NSObject

@property (nonatomic, strong) CLLocation *currentLocation;

@property (nonatomic, strong) id<FTLocationManagerInterface> eventHandler;

//-(void)launchManager:(UIViewController *)controller;
-(void)launchManager;

@end

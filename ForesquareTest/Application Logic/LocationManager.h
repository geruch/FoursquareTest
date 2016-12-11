//
//  LocationManager.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 12.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject

@property (nonatomic, strong) CLLocation *currentLocation;

-(void)launchManager:(UIViewController *)controller;

@end

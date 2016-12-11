//
//  Location.h
//  ForesquareTest
//
//  Created by Команда Complex Systems on 07.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location : NSObject

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, copy) NSString *address;

@end

//
//  FTLocationsListModuleInterface.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 19.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol FTLocationsListModuleInterface <NSObject>

-(void)saveNewLocation:(NSInteger)pointNumber;
-(void)getLocationsList;

@end

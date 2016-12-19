//
//  FTLocationsListIOInterface.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 19.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol FTLocationsListInputInterface <NSObject>

-(void)saveLocation:(NSInteger)pointNumber;
-(void)getLocationsList;

@end

@protocol FTLocationsListOutputInterface <NSObject>

-(void)didUpdateLocationsList:(NSArray *)list selectedIndex:(NSInteger)index;

@end

//
//  Venue.h
//  ForesquareTest
//
//  Created by Команда Complex Systems on 06.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTLocation.h"
#import "FTCategory.h"

@interface FTVenue : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *venueId;
@property (nonatomic, strong) FTLocation *location;
@property (nonatomic, strong) FTCategory *category;

@end

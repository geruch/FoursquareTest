//
//  Venue.h
//  ForesquareTest
//
//  Created by Команда Complex Systems on 06.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "Category.h"

@interface Venue : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *venueId;
@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) Category *category;

@end

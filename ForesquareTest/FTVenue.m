//
//  Venue.m
//  ForesquareTest
//
//  Created by Команда Complex Systems on 06.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTVenue.h"

@implementation FTVenue

- (id)init
{
    self = [super init];
    if (self)
    {
        self.location = [[FTLocation alloc] init];
        self.category = [[FTCategory alloc] init];
    }
    return self;
}

@end

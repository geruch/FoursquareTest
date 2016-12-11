//
//  Venue.m
//  ForesquareTest
//
//  Created by Команда Complex Systems on 06.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "Venue.h"

@implementation Venue

- (id)init
{
    self = [super init];
    if (self)
    {
        self.location = [[Location alloc] init];
        self.category = [[Category alloc] init];
    }
    return self;
}

@end

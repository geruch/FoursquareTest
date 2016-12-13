//
//  ObjectMaker.m
//  ForesquareTest
//
//  Created by Команда Complex Systems on 07.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "ObjectMaker.h"
#import "Venue.h"

#import "UIImageView+AFNetworking.h"

@implementation ObjectMaker

- (NSArray *)convertToObjects:(NSArray *)venueObjects
{
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:venueObjects.count];
    for (NSArray *object in venueObjects)
    {

        NSDictionary *venue = [object valueForKey:@"venue"];
        Venue *plainVenue = [[Venue alloc] init];
        plainVenue.venueId = venue[@"id"];
        plainVenue.name = venue[@"name"];
        
        plainVenue.location.address = venue[@"location"][@"address"];
        plainVenue.location.distance = venue[@"location"][@"distance"];
        [plainVenue.location setCoordinate:CLLocationCoordinate2DMake([venue[@"location"][@"lat"] doubleValue], [venue[@"location"][@"lng"] doubleValue])];
    
        NSDictionary *category = [venue[@"categories"] objectAtIndex:0];
        plainVenue.category.identifier = category[@"id"];
        plainVenue.category.name = category[@"name"];
        plainVenue.category.pluralName = category[@"pluralName"];
        plainVenue.category.pictureURL = category[@"icon"][@"prefix"];
        
        [objects addObject:plainVenue];
    }
    return objects;
}

-(NSArray *)convertToAdditionalObjects:(NSArray *)venueObjects
{
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:venueObjects.count];
    for (NSDictionary *object in venueObjects)
    {
        
        Venue *plainVenue = [[Venue alloc] init];
        plainVenue.venueId = object[@"id"];
        plainVenue.name = object[@"name"];
        [plainVenue.location setCoordinate:CLLocationCoordinate2DMake([object[@"location"][@"lat"] doubleValue], [object[@"location"][@"lng"] doubleValue])];
        plainVenue.location.distance = object[@"location"][@"distance"];
        plainVenue.location.address = object[@"location"][@"address"];
        
        NSDictionary *category = [object[@"categories"] objectAtIndex:0];
        plainVenue.category.identifier = category[@"id"];
        plainVenue.category.name = category[@"name"];
        plainVenue.category.pluralName = category[@"pluralName"];
        plainVenue.category.pictureURL = category[@"icon"][@"prefix"];
              
        [objects addObject:plainVenue];
    }
    return objects;
}

- (NSArray *)convertToCategories:(NSArray *)categoryObjects
{
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:categoryObjects.count];
    NSArray *categories  = [categoryObjects valueForKey:@"categories"];
    for (NSArray *object in categories)
    {
        NSArray *categoriesList = [object valueForKey:@"categories"];

        for(NSDictionary *categoryObject in categoriesList)
        {
        Category *category = [[Category alloc] init];
        
        category.identifier = categoryObject[@"id"];
        category.name = categoryObject[@"name"];
        category.pluralName = categoryObject[@"pluralName"];
        category.pictureURL = categoryObject[@"icon"][@"prefix"];
        
        [objects addObject:category];
        }
    }
    return objects;
}

@end

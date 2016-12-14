//
//  ObjectMaker.h
//  ForesquareTest
//
//  Created by Команда Complex Systems on 07.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTObjectMaker : NSObject

- (NSArray *)convertToObjects:(NSArray *)venueObjects;
- (NSArray *)convertToCategories:(NSArray *)categoryObjects;
- (NSArray *)convertToAdditionalObjects:(NSArray *)venueObjects;

@end

//
//  ObjectMaker.h
//  ForesquareTest
//
//  Created by Команда Complex Systems on 07.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectMaker : NSObject

- (NSArray *)convertToObjects:(NSArray *)venueObjects;
- (NSArray *)convertToCategories:(NSArray *)categoryObjects;

@end

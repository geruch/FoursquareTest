//
//  FTLocationsListInterface.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 19.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FTLocationsListInterface <NSObject>

-(void)updateViewWithData:(NSArray *)locations index:(NSInteger)index;

@end

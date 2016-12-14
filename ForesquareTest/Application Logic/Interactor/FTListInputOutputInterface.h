//
//  FTInputOutputInterface.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 14.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FTListInputInterface <NSObject>

-(void)updateCategories;
-(void)updateLocationData;
-(void)updateVenuesItems;

@end

@protocol FTListOutputInterface <NSObject>

-(void)didUpdateCategories;
-(void)didUpdateVenuesItems;
-(void)didUpdateLocationData;

@end

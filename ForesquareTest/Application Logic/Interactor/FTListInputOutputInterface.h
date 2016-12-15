//
//  FTInputOutputInterface.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 14.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTCategory.h"

#import <Foundation/Foundation.h>

@protocol FTListInputInterface <NSObject>

-(void)updateCategories;
-(void)updateLocationData;
-(void)updateVenuesItems;
-(void)getAdditionalVenuesForCategory:(FTCategory *)category forIndexPath:(NSIndexPath *)indexPath;
-(void)updateLocationData;

@end

@protocol FTListOutputInterface <NSObject>

-(void)didUpdateCategories;
-(void)didUpdateVenuesItems:(NSDictionary *)dictionary;
-(void)didGetAdditionalVenues:(NSArray *)items forIndexPath:(NSIndexPath *)indexPath;
-(void)didUpdateLocationData;

@end

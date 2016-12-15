//
//  FTListPresenter.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 14.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTListPresenter.h"
#import "FTCategory.h"
#import "FTVenue.h"
#import "FTLocationManager.h"
#import "FTNetworkManager.h"
#import "FTObjectMaker.h"
#import "FTListModelManager.h"

@interface FTListPresenter ()

@end


@implementation FTListPresenter

-(void)collectVenuesData
{
    [self.listInteractor updateVenuesItems];    
}

-(void)collectVenueCategories
{
    [self.listInteractor updateCategories];
}

-(void)loadAdditionalVenuesWithCategory:(FTCategory *)category forIndexPath:(NSIndexPath *)indexPath
{
    [self.listInteractor getAdditionalVenuesForCategory:category forIndexPath:indexPath];
}

-(void)didUpdateVenuesItems:(NSDictionary *)dictionary
{
    [self.userInterface showListData:dictionary];
}

-(void)didGetAdditionalVenues:(NSArray *)items forIndexPath:(nonnull NSIndexPath *)indexPath
{
    [self.userInterface insertAdditionalVenues:items forIndexPath:indexPath];
}

-(void)updateLocation
{
    [self.listInteractor updateLocationData];
}

@end

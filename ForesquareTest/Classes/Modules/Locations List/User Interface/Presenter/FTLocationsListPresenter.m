//
//  FTLocationsListPresenter.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 19.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTLocationsListPresenter.h"

@implementation FTLocationsListPresenter

-(void)saveNewLocation:(NSInteger)pointNumber
{
    [self.locationsInteractor saveLocation:pointNumber];
}

-(void)getLocationsList
{
    [self.locationsInteractor getLocationsList];
}

-(void)didUpdateLocationsList:(NSArray *)list selectedIndex:(NSInteger)index
{
    [self.userInterface updateViewWithData:list index:index];
}

@end

//
//  FTLocationsListInteractor.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 19.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTLocationsListInteractor.h"
#import "FTListModelManager.h"

@implementation FTLocationsListInteractor

-(void)saveLocation:(NSInteger)pointNumber
{
    [[FTListModelManager sharedManager] settingPresetLocation:pointNumber];
}

-(void)getLocationsList
{
    [self.output didUpdateLocationsList:[[FTListModelManager sharedManager] getLocationsList]
                          selectedIndex:[FTListModelManager sharedManager].presetLocation];
}

@end

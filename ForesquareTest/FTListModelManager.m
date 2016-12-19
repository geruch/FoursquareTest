//
//  FTListModelManager.m
//  ForesquareTest
//
//  Created by Команда Complex Systems on 09.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTListModelManager.h"
#import "FTLocation.h"

@interface FTListModelManager ()

@property (nonatomic, strong) NSArray *coordinatesList;

@end

@implementation FTListModelManager

-(void)initCoordinatesList
{
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    FTLocation *tmpCoord = [[FTLocation alloc] init];
    tmpCoord.address = @"Oakland";
    tmpCoord.coordinate = CLLocationCoordinate2DMake(37.823490, -122.270960);
    [tmp addObject:tmpCoord];
    FTLocation *tmpCoord1 = [[FTLocation alloc] init];
    tmpCoord1.address = @"Berkeley";
    tmpCoord1.coordinate = CLLocationCoordinate2DMake(37.877272, -122.283529);
    [tmp addObject:tmpCoord1];
    FTLocation *tmpCoord2 = [[FTLocation alloc] init];
    tmpCoord2.address = @"San Francisco";
    tmpCoord2.coordinate = CLLocationCoordinate2DMake(37.767143, -122.399865);
    [tmp addObject:tmpCoord2];
    
    self.coordinatesList = [NSArray arrayWithArray:tmp];
}

-(void)settingPresetLocation:(NSInteger)selection
{
    self.presetLocation = selection;
    
    switch(selection)
    {
        case 0:
            self.userCoordinates = CLLocationCoordinate2DMake(0, 0);
            break;
            
        case 1:
            self.userCoordinates = [[self.coordinatesList objectAtIndex:0] coordinate];
            break;
            
        case 2:
            self.userCoordinates = [[self.coordinatesList objectAtIndex:1] coordinate];
            break;
            
        case 3:
            self.userCoordinates = [[self.coordinatesList objectAtIndex:2] coordinate];
            break;
            
        default:
            break;
    }
}

-(NSArray *)getLocationsList
{
    return self.coordinatesList;
}

#pragma mark - Singleton Method

+ (FTListModelManager *)sharedManager
{
    static FTListModelManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        sharedManager.categories = [NSMutableArray array];
        sharedManager.filter = [NSMutableDictionary dictionary];
        sharedManager.presetLocation = 0;
        [sharedManager initCoordinatesList];
    });
    return sharedManager;
}

@end

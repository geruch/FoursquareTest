//
//  FTListModelManager.h
//  ForesquareTest
//
//  Created by Команда Complex Systems on 09.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FTListModelManager : NSObject

@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableDictionary *filter;
@property (nonatomic) CLLocationCoordinate2D userCoordinates;
@property (nonatomic) NSInteger presetLocation;

+ (FTListModelManager *)sharedManager;
-(void)settingPresetLocation:(NSInteger)index;
-(NSArray *)getLocationsList;

@end

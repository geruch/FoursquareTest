//
//  FTListModelManager.m
//  ForesquareTest
//
//  Created by Команда Complex Systems on 09.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTListModelManager.h"

@implementation FTListModelManager

#pragma mark - Singleton Method

+ (FTListModelManager *)sharedManager
{
    static FTListModelManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        sharedManager.categories = [NSMutableArray array];
    });
    return sharedManager;
}

@end

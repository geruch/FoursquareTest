//
//  FTFilterInteractor.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 16.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTFilterInteractor.h"
#import "FTListModelManager.h"

@interface FTFilterInteractor ()

@property (nonatomic, strong) FTListModelManager *manager;

@end

@implementation FTFilterInteractor

-(void)saveCategoriesFilter:(NSMutableDictionary *)dictionary
{
    [FTListModelManager sharedManager].filter = dictionary;
}

@end

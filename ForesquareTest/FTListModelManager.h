//
//  FTListModelManager.h
//  ForesquareTest
//
//  Created by Команда Complex Systems on 09.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTListModelManager : NSObject

@property (nonatomic, strong) NSMutableArray *categories;

+ (FTListModelManager *)sharedManager;

@end

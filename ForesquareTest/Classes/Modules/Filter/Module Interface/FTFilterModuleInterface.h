//
//  FTFilterModuleInterface.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 16.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FTFilterModuleInterface <NSObject>

-(void)saveCategoriesFilter:(NSMutableDictionary *)dictionary;
-(void)applyFilter;

@end

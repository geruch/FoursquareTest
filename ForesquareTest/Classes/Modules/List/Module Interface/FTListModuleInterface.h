//
//  FTListModuleInterface.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 14.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTCategory.h"
#import <Foundation/Foundation.h>

@protocol FTListModuleInterface <NSObject>

- (void)updateLocation;
- (void)loadAdditionalVenuesWithCategory:(FTCategory *)category forIndexPath:(NSIndexPath *)indexPath;

@end

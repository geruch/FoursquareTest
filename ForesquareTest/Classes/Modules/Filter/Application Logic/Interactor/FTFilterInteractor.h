//
//  FTFilterInteractor.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 16.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTFilterInputOutputInterface.h"
#import <Foundation/Foundation.h>

@interface FTFilterInteractor : NSObject<FTFilterInputInterface>

- (void)saveSelectedCategories:(NSDictionary *)categories;

@end

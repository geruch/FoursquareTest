//
//  FTLocationsListInteractor.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 19.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTLocationsListIOInterface.h"
#import "FTLocationsListIOInterface.h"
#import <Foundation/Foundation.h>

@interface FTLocationsListInteractor : NSObject<FTLocationsListInputInterface>

@property (nonatomic, weak) id<FTLocationsListOutputInterface> output;

@end

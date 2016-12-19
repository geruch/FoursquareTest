//
//  FTListInteractor.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 14.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FTListInputOutputInterface.h"
//#import "FTListDataManager.h"

@interface FTListInteractor : NSObject<FTListInputInterface>

@property (nonatomic, weak) id<FTListOutputInterface> output;

@end

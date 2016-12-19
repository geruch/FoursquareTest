//
//  FTLocationsListModuleVC.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 19.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTLocationsListInterface.h"
#import "FTLocationsListModuleInterface.h"

#import <UIKit/UIKit.h>

@interface FTLocationsListModuleVC : UIViewController<FTLocationsListInterface>

@property (nonatomic, strong) id<FTLocationsListModuleInterface>    eventHandler;


@end

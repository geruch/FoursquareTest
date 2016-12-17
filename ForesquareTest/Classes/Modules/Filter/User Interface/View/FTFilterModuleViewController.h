//
//  FTFilterModuleViewController.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 16.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTFilterViewInterface.h"
#import "FTFilterModuleInterface.h"

#import <UIKit/UIKit.h>

@interface FTFilterModuleViewController : UIViewController<FTFilterViewInterface>

@property (nonatomic, strong) id<FTFilterModuleInterface>    eventHandler;

@end

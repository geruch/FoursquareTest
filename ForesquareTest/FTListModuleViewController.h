//
//  ViewController.h
//  ForesquareTest
//
//  Created by Команда Complex Systems on 06.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FTListModuleInterface.h"
#import "FTListViewInterface.h"

@interface FTListModuleViewController : UIViewController <FTListViewInterface>

@property (nonatomic, weak) id<FTListModuleInterface> eventHandler;

@end


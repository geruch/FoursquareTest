//
//  FTListPresenter.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 14.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTListModuleViewController.h"
#import "FTListWireframe.h"
#import "FTListModuleInterface.h"
#import "FTListInputOutputInterface.h"

@protocol FTListViewInterface;
@class FTListWireframe;

@interface FTListPresenter : NSObject<FTListModuleInterface, FTListOutputInterface>

@property (nonatomic, strong) id<FTListInputInterface>    listInteractor;
@property (nonatomic, strong) FTListWireframe*        listWireframe;

@property (nonatomic, strong) FTListModuleViewController<FTListViewInterface> *userInterface;

@end

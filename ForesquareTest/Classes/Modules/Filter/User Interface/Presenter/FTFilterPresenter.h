//
//  FTListPresenter.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 16.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//
#import "FTFilterModuleInterface.h"
#import "FTFilterModuleViewController.h"
#import "FTFilterInteractor.h"
#import "FTFilterWireframe.h"

#import <Foundation/Foundation.h>

@interface FTFilterPresenter : NSObject <FTFilterModuleInterface>

@property (nonatomic, strong) FTFilterModuleViewController *userInterface;

@property (nonatomic, strong) FTFilterInteractor *filterInteractor;
@property (nonatomic, strong) FTFilterWireframe *filterWireframe;

@property (nonatomic, weak) id<FTFilterModuleInterface> filterModuleDelegate;

@end

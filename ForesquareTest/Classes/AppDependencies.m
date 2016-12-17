//
//  AppDepencies.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 15.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "AppDependencies.h"

#import "FTRootNavControllerWireframe.h"

#import "FTListWireframe.h"
#import "FTListInteractor.h"
#import "FTListPresenter.h"

#import "FTFilterWireframe.h"
#import "FTFilterInteractor.h"
#import "FTFilterPresenter.h"

@interface AppDependencies ()

@property (nonatomic, strong) FTListWireframe *listWireframe;

@end

@implementation AppDependencies

- (id)init
{
    if (self = [super init])
    {
        [self configureDependencies];
    }
    
    return self;
}

- (void)installRootViewControllerIntoWindow:(UIWindow *)window
{
//    [self.navWireFrame navigationControllerFromWindow:window];
    [self.listWireframe presentListInterfaceFromWindow:window];
}

- (void)configureDependencies
{
    //Navigation Controller
    FTRootNavControllerWireframe *rootWireFrame = [[FTRootNavControllerWireframe alloc] init];
    
    //List module
    FTListWireframe *listWireframe = [[FTListWireframe alloc] init];
    FTListPresenter *listPresenter = [[FTListPresenter alloc] init];
    FTListInteractor *listInteractor = [[FTListInteractor alloc] init];
    
    //Filter module
    FTFilterWireframe *filterWireframe = [[FTFilterWireframe alloc] init];
    FTFilterPresenter *filterPresenter = [[FTFilterPresenter alloc] init];
    FTFilterInteractor *filterInteractor = [[FTFilterInteractor alloc] init];

    //Filter module
    //    filterInteractor.output = filterPresenter;
    filterPresenter.filterInteractor = filterInteractor;
    filterPresenter.filterWireframe = filterWireframe;
    filterWireframe.filterPresenter = filterPresenter;
    //    filterWireframe.rootWireframe = rootWireFrame;
    //    self.listWireframe = listWireframe;
    
    //List module
    listInteractor.output = listPresenter;
    listPresenter.listInteractor = listInteractor;
    listPresenter.listWireframe = listWireframe;
    listWireframe.listPresenter = listPresenter;
    listWireframe.rootWireframe = rootWireFrame;
    listWireframe.filterWireframe = filterWireframe;
    self.listWireframe = listWireframe;
    
}

@end

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

#import "FTLocationsListWireframe.h"
#import "FTLocationsListInteractor.h"
#import "FTLocationsListPresenter.h"

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
    
    //Locations List module
    FTLocationsListWireframe *locationsWireframe = [[FTLocationsListWireframe alloc] init];
    FTLocationsListPresenter *locationsPresenter = [[FTLocationsListPresenter alloc] init];
    FTLocationsListInteractor *locationsInteractor = [[FTLocationsListInteractor alloc] init];

    //Filter module
    filterPresenter.filterInteractor = filterInteractor;
    filterPresenter.filterWireframe = filterWireframe;
    filterWireframe.filterPresenter = filterPresenter;
    
    //Locations List module
    locationsPresenter.locationsInteractor = locationsInteractor;
    locationsPresenter.locationsWireframe = locationsWireframe;
    locationsWireframe.locationsPresenter = locationsPresenter;
    locationsInteractor.output = locationsPresenter;
    
    //List module
    listInteractor.output = listPresenter;
    listPresenter.listInteractor = listInteractor;
    listPresenter.listWireframe = listWireframe;
    listWireframe.listPresenter = listPresenter;
    listWireframe.rootWireframe = rootWireFrame;
    listWireframe.filterWireframe = filterWireframe;
    listWireframe.locationsWireframe = locationsWireframe;
    self.listWireframe = listWireframe;
    
}

@end

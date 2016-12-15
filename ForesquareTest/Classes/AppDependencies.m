//
//  AppDepencies.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 15.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "AppDependencies.h"
#import "FTListWireframe.h"
#import "FTListInteractor.h"
#import "FTListPresenter.h"
#import "FTRootNavControllerWireframe.h"

@interface AppDependencies ()

@property (nonatomic, strong) FTRootNavControllerWireframe *navWireFrame;

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
    [self.navWireFrame navigationControllerFromWindow:window];
}

- (void)configureDependencies
{
    //Navigation Controller
    self.navWireFrame = [[FTRootNavControllerWireframe alloc] init];
    
    //List module
    FTListWireframe *listWireframe = [[FTListWireframe alloc] init];
    FTListPresenter *listPresenter = [[FTListPresenter alloc] init];
    FTListInteractor *listInteractor = [[FTListInteractor alloc] init];
    
    //List module
    listInteractor.output = listPresenter;
    listPresenter.listInteractor = listInteractor;
    listPresenter.listWireframe = listWireframe;
    listWireframe.listPresenter = listPresenter;
}

@end

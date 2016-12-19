//
//  FTLocationsListPresenter.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 19.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTLocationsListInterface.h"
#import "FTLocationsListModuleInterface.h"
#import "FTLocationsListInteractor.h"
#import "FTLocationsListWireframe.h"
#import "FTLocationsListModuleVC.h"

#import <Foundation/Foundation.h>

@interface FTLocationsListPresenter : NSObject<FTLocationsListModuleInterface, FTLocationsListOutputInterface>

@property (nonatomic, strong) FTLocationsListModuleVC <FTLocationsListInterface> *userInterface;

@property (nonatomic, strong) FTLocationsListInteractor *locationsInteractor;
@property (nonatomic, strong) FTLocationsListWireframe *locationsWireframe;

@property (nonatomic, weak) id<FTLocationsListModuleInterface> locationsModuleDelegate;

@end

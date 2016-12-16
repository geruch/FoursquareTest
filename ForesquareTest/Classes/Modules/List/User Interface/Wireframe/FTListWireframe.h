//
//  FTListWireframe.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 14.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//


#import "FTRootNavControllerWireframe.h"

#import <Foundation/Foundation.h>

@class FTListPresenter;

@interface FTListWireframe : NSObject

@property (nonatomic, strong) FTListPresenter *listPresenter;

@property (nonatomic, strong) FTRootNavControllerWireframe *rootWireframe;

- (void)presentListInterfaceFromWindow:(UIWindow *)window;

@end

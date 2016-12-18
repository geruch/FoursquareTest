//
//  FTListPresenter.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 16.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTFilterPresenter.h"

@implementation FTFilterPresenter

-(void)saveCategoriesFilter:(NSMutableDictionary *)dictionary
{
    [self.filterInteractor saveCategoriesFilter:dictionary];
    [self.userInterface dismissView];
}


@end

//
//  FTListViewInterface.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 14.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FTListViewInterface <NSObject>

- (void)showListData:(NSDictionary *)data;
- (void)reloadEntries;

@end

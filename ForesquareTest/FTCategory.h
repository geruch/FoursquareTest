//
//  Category.h
//  ForesquareTest
//
//  Created by Команда Complex Systems on 07.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FTCategory : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pluralName;
@property (nonatomic, copy) NSString *pictureURL;
@property (nonatomic, strong) UIImageView *picture;

@end

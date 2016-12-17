//
//  FTCategoryCell.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 17.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTCategory.h"

#import <UIKit/UIKit.h>

@interface FTCategoryCell : UITableViewCell

@property (nonatomic, copy) NSString *name;

-(void)initWithCategory:(FTCategory *)category;

@end

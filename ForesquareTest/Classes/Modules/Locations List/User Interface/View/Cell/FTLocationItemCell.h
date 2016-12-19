//
//  FTLocationItemCell.h
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 19.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FTLocationItemCell : UITableViewCell

-(void)initWithTitle:(NSString *)title coordinates:(CLLocationCoordinate2D)coords;

@end

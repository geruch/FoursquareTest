//
//  FTLocationItemCell.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 19.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTLocationItemCell.h"

@interface FTLocationItemCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleText;
@property (nonatomic, weak) IBOutlet UILabel *coordinatsText;

@end

@implementation FTLocationItemCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)initWithTitle:(NSString *)title coordinates:(CLLocationCoordinate2D)coords
{
    self.titleText.text = title;
    if(coords.latitude == 0 && coords.longitude == 0)
    {
        [self.coordinatsText removeFromSuperview];
    }
    else
    {
        self.coordinatsText.text = [NSString stringWithFormat:@"%g, %g", coords.latitude,coords.longitude];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end

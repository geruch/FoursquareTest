//
//  VenueCell.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 11.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "VenueCell.h"

@interface VenueCell ()

@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *address;
@property (nonatomic, weak) IBOutlet UILabel *distance;

@end

@implementation VenueCell

-(void)initWithVenue:(Venue *)venue
{
    self.address.text = venue.location.address;
    self.distance.text = [[venue.location.distance stringValue] stringByAppendingString:@"m"];
    self.name.text = venue.name;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

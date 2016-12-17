//
//  FTCategoryCell.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 17.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTCategoryCell.h"

#import "UIImageView+AFNetworking.h"

@interface FTCategoryCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameText;
@property (nonatomic, weak) IBOutlet UIImageView *icon;

@end

@implementation FTCategoryCell

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)initWithCategory:(FTCategory *)category
{
    self.nameText.text = category.name;
    self.name = category.name;
    if(!category.picture)
    {
        [self loadCategoryIcon:category];
    }
    else
    {
        self.icon.image = category.picture.image;
    }
}

-(void)loadCategoryIcon:(FTCategory *)category
{
    category.picture = [[UIImageView alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@", category.pictureURL,@"64",@".png"];
    url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [category.picture setImageWithURLRequest:request
                            placeholderImage:nil
                                     success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                         [category.picture initWithImage:image];
                                         self.icon.image = image;
                                         NSLog(@"icon download - success");                                                  }
                                     failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                         NSLog(@"icon download - error %@",response);
                                     }];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

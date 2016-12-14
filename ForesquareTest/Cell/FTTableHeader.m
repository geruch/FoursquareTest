//
//  FTTableHeader.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 11.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTTableHeader.h"

#import "UIImageView+AFNetworking.h"

@interface FTTableHeader ()

@property (nonatomic, weak) IBOutlet UILabel *categoryName;
@property (nonatomic, weak) IBOutlet UIImageView *categoryPicture;

@end

@implementation FTTableHeader

-(void)initWithCategory:(FTCategory *)category
{
    self.categoryName.text = category.name;
    if(!category.picture)
    {
        [self loadCategoryIcon:category];
    }
    else
    {
        self.categoryPicture.image = category.picture.image;
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
                                         self.categoryPicture.image = image;
                                         NSLog(@"icon download - success");                                                  }
                                     failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                         NSLog(@"icon download - error %@",response);
                                     }];
}

@end

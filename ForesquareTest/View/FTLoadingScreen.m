//
//  FTLoadingScreen.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 12.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTLoadingScreen.h"

@interface FTLoadingScreen ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic, weak) IBOutlet UILabel *loadingText;

@end

@implementation FTLoadingScreen

//-(void)initialize
//{
//    if(!self)
//    {
//        self = [[[NSBundle mainBundle]loadNibNamed:@"FTLoadingScreen" owner:nil options:nil] objectAtIndex:0];
//    }
//}

-(void)startLoadingIndication
{
    [self.indicator startAnimating];
}

-(void)stopLoadingIndication
{
    [self.indicator stopAnimating];
}


@end

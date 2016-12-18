//
//  FTListInteractor.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 14.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTListInteractor.h"
#import "FTCategory.h"
#import "FTVenue.h"
#import "FTLocationManager.h"
#import "FTNetworkManager.h"
#import "FTObjectMaker.h"
#import "FTListModelManager.h"

@interface FTListInteractor ()

@property (nonatomic, strong) FTLocationManager *locationManager;

@end

@implementation FTListInteractor

-(void)updateVenuesItems
{
    NSString *userLocation;
    if(!self.locationManager.currentLocation)
    {
        userLocation = @"37.7858,-122.406";
    }
    else
    {
        userLocation = [NSString stringWithFormat:@"%f,%f",self.locationManager.currentLocation.coordinate.latitude,self.locationManager.currentLocation.coordinate.longitude];
    }
    
    [[FTNetworkManager sharedHttpClient] getNearbyVenuesWithLocation:userLocation SuccessBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        //        NSLog(@"%@", responseObject);
        
        FTObjectMaker *fabric = [[FTObjectMaker alloc] init];
        NSArray *tmp = [[responseObject valueForKeyPath:@"response.groups.items"] objectAtIndex:0];
        NSArray *objects = [fabric convertToObjects:tmp];
        
        NSDictionary *dictionary = [self transformToDictionary:objects];
        
        [self.output didUpdateVenuesItems:dictionary];
        
    } FailBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"Error response: %@",errorResponse);
    } andParameters:nil];
}

-(void)updateLocationData
{
    self.locationManager = [[FTLocationManager alloc] init];
    self.locationManager.eventHandler = self;
//    [self.locationManager launchManager:self];
    [self.locationManager launchManager];
}

-(void)getAdditionalVenuesForCategory:(FTCategory *)category forIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *userLocation = [NSString stringWithFormat:@"%f,%f",self.locationManager.currentLocation.coordinate.latitude,self.locationManager.currentLocation.coordinate.longitude];
    
    [[FTNetworkManager sharedHttpClient] getMoreVenuesWithLocation:userLocation category:category SuccessBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        FTObjectMaker *fabric = [[FTObjectMaker alloc] init];
        NSArray *tmp = [responseObject valueForKeyPath:@"response.venues"];
        NSArray *objects = [fabric convertToAdditionalObjects:tmp];
        
        
        [self.output didGetAdditionalVenues:objects forIndexPath:indexPath];
        
        
    } FailBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"Error response: %@",errorResponse);
    } andParameters:nil];
}

-(void)updateCategories
{ 
    [[FTNetworkManager sharedHttpClient] getVenueCategoriesWithSuccessBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        //        NSLog(@"%@", responseObject);
        
        FTObjectMaker *fabric = [[FTObjectMaker alloc] init];
        NSArray *tmp = [responseObject valueForKeyPath:@"response"];
        NSMutableArray *objects = [NSMutableArray arrayWithArray:[fabric convertToCategories:tmp]];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        [objects sortUsingDescriptors:@[sort]];
        [[FTListModelManager sharedManager].categories addObjectsFromArray:objects];
        
        [self updateVenuesItems];
        
    } FailBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"Error response: %@",errorResponse);
    } andParameters:nil];
}


-(NSDictionary *)transformToDictionary:(NSArray *)objects
{
    NSDictionary *test = [self fillDictionaryWithCategories];
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:test];
    for(FTVenue *venue in objects)
    {
        NSMutableArray *tmp = [result objectForKey:venue.category.name];
        if(tmp == [NSNull null])
        {
            tmp = [NSMutableArray array];
        }
        
        [tmp addObject:venue];
        [result setValue:tmp forKey:venue.category.name];
    }
    
    [self sortValuesInDictionary:result];
    
    return [NSDictionary dictionaryWithDictionary:result];
}

-(NSDictionary *)fillDictionaryWithCategories
{
    NSArray *objects = [FTListModelManager sharedManager].categories;
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for(FTCategory *category in objects)
    {
        [result setObject:[NSNull null] forKey:category.name];
    }
    
    return [NSDictionary dictionaryWithDictionary:result];
}

-(NSMutableDictionary *)sortValuesInDictionary:(NSMutableDictionary *)dictionary
{
    for(NSString *key in dictionary.allKeys)
    {
        NSMutableArray *values = [dictionary objectForKey:key];
        if(values!=[NSNull null] && values.count>1)
        {
            [self sortValuesInArray:values];
        }
    }
    return dictionary;
}

-(void)sortValuesInArray:(NSMutableArray *)array
{
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"location.distance" ascending:YES];
    [array sortUsingDescriptors:@[sort]];
}

#pragma mark - FTLocationManagerInterface

-(void)updateUserLocation
{
//    [self updateVenuesItems];
    [self updateCategories];
}

@end

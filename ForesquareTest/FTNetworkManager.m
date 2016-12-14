//
//  NetworkManager.m
//  ForesquareTest
//
//  Created by Команда Complex Systems on 06.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTNetworkManager.h"

@interface FTNetworkManager ()

@property (nonatomic, copy) NSString *clientId;
@property (nonatomic, copy) NSString *secret;
@property (nonatomic, copy) NSString *appURL;

@end

@implementation FTNetworkManager

-(void)getNearbyVenuesWithLocation:(NSString *)coordinats
                      SuccessBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))successBlock
                         FailBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failBlock
                     andParameters:(NSDictionary *)params
{
//    [self setHeaders];
    
    NSMutableDictionary *newParams = [NSMutableDictionary dictionaryWithDictionary:params];

    [newParams setValue:self.clientId forKey:@"client_id"];
    [newParams setValue:self.secret forKey:@"client_secret"];
    [newParams setValue:@"20150503" forKey: @"v"];
    [newParams setValue:coordinats forKey:@"ll"];
    [newParams setValue:@"50" forKey:@"limit"];
    [self GET:@"venues/explore" parameters:newParams success:successBlock failure:failBlock];
}

-(void)getMoreVenuesWithLocation:(NSString *)coordinats category:(FTCategory *)category
                    SuccessBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))successBlock
                         FailBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failBlock
                     andParameters:(NSDictionary *)params
{
    //    [self setHeaders];
    
    NSMutableDictionary *newParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [newParams setValue:self.clientId forKey:@"client_id"];
    [newParams setValue:self.secret forKey:@"client_secret"];
    [newParams setValue:@"20150503" forKey: @"v"];
    [newParams setValue:coordinats forKey:@"ll"];
    [newParams setValue:@"10" forKey:@"limit"];
    [newParams setValue:category.identifier forKey:@"categoryId"];
    //    NSString *accessToken  = [self classAttributes][kFOURSQUARE_ACCESS_TOKEN];
    //    if ([accessToken length] > 0)
    //        [parametersString appendFormat:@"&oauth_token=%@",accessToken];
    
    [self GET:@"venues/search" parameters:newParams success:successBlock failure:failBlock];
}

-(void)getVenueCategoriesWithSuccessBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))successBlock
                                 FailBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failBlock
                             andParameters:(NSDictionary *)params
{
    NSMutableDictionary *newParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [newParams setValue:self.clientId forKey:@"client_id"];
    [newParams setValue:self.secret forKey:@"client_secret"];
    [newParams setValue:@"20150503" forKey: @"v"];
    
    [self GET:@"venues/categories" parameters:newParams success:successBlock failure:failBlock];
}

+(FTNetworkManager *)sharedHttpClient
{
    static FTNetworkManager *_sharedHttpClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHttpClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.foursquare.com/v2/"]];
    });
    return _sharedHttpClient;
}

-(void)setHeaders
{
    self.requestSerializer = [AFJSONRequestSerializer serializer];
}

+(void)setupFoursquareWithClientId:(NSString *)clientId
                              secret:(NSString *)secret
                         callbackURL:(NSString *)appURL
{
    [self sharedHttpClient].clientId = clientId;
    [self sharedHttpClient].secret = secret;
    [self sharedHttpClient].appURL = appURL;
}

@end

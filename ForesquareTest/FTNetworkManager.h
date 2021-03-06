//
//  NetworkManager.h
//  ForesquareTest
//
//  Created by Команда Complex Systems on 06.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "FTCategory.h"

@interface FTNetworkManager : AFHTTPSessionManager <NSURLSessionDownloadDelegate>

-(void)getNearbyVenuesWithLocation:(NSString *)coordinats SuccessBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))successBlock
                         FailBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failBlock
                     andParameters:(NSDictionary *)params;

- (void)getVenueCategoriesWithSuccessBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))successBlock
                              FailBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failBlock
                          andParameters:(NSDictionary *)params;

-(void)getMoreVenuesWithLocation:(NSString *)coordinats category:(FTCategory *)category
                    SuccessBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))successBlock
                       FailBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failBlock
                   andParameters:(NSDictionary *)params;

+ (FTNetworkManager *)sharedHttpClient;
+ (void) setupFoursquareWithClientId:(NSString *)clientId
                              secret:(NSString *)secret
                         callbackURL:(NSString *)appURL;
@end

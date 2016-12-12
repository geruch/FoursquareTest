//
//  LocationManager.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 12.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic) BOOL isFirstAttempt;

@end

@implementation LocationManager

-(void)launchManager:(UIViewController *)controller
{
    self.locationManager = [[CLLocationManager alloc]init];
    self.isFirstAttempt = YES;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 500.0;
    self.locationManager.delegate = self;

    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined )
    {
        // Первый запуск
        [self.locationManager requestWhenInUseAuthorization];
    }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse ||
               [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)
    {
        // Есть разрешение
        [self.locationManager startUpdatingLocation];
    }
    else
    {
        // Нет разрешения
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Геолокация запрещена"
                                                                       message:@"Пожалуйста, включите геолокацию для этого приложения"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                                              }];
        
        [alert addAction:defaultAction];
        [controller presentViewController:alert animated:YES completion:nil];
    }
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self.locationManager stopUpdatingLocation];
    self.currentLocation = newLocation;
    if(self.isFirstAttempt)
    {
        self.isFirstAttempt = NO;
        [self.eventHandler updateUserLocation];
        NSLog(@"Stop updating location");
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location manager did fail with error %@", error);
    [self.locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus) status
{
    //Разрешена геолокация при запущенном приложении
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [manager startUpdatingLocation];
    }
}

@end

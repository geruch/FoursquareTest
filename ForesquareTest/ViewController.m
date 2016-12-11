//
//  ViewController.m
//  ForesquareTest
//
//  Created by Команда Complex Systems on 06.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"
#import "ObjectMaker.h"
#import "Venue.h"
#import "VenueCell.h"
#import "ModelManager.h"
#import "TableHeader.h"

#import "LocationManager.h"

#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDictionary *tableData;
@property (nonatomic, strong) LocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[LocationManager alloc] init];
    [self.locationManager launchManager:self];
    
    [self configureView];
    
    [self collectVenuesData];
    [self collectVenueCategories];
}

- (void)configureView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"VenueCell" bundle:nil] forCellReuseIdentifier:@"venueCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    
    self.tableData = [NSDictionary dictionary];
}

-(void)collectVenuesData
{
    CLLocation *coordinats = self.locationManager.currentLocation;
    NSString *userLocation;
    if(!coordinats)
    {
        userLocation = @"37.7858,-122.406";
    }
    else
    {
        userLocation = [NSString stringWithFormat:@"%f,%f",coordinats.coordinate.latitude,coordinats.coordinate.longitude];
    }
    
    [[NetworkManager sharedHttpClient] getNearbyVenuesWithLocation:userLocation SuccessBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSLog(@"%@", responseObject);
        
        ObjectMaker *fabric = [[ObjectMaker alloc] init];
        NSArray *tmp = [[responseObject valueForKeyPath:@"response.groups.items"] objectAtIndex:0];
        NSArray *objects = [fabric convertToObjects:tmp];
        
        self.tableData = [self transformToDictionary:objects];
        [self.tableView reloadData];
        
    } FailBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"Error response: %@",errorResponse);
    } andParameters:nil];
}

-(void)collectVenueCategories
{
    [[NetworkManager sharedHttpClient] getVenueCategoriesWithSuccessBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSLog(@"%@", responseObject);
        
        ObjectMaker *fabric = [[ObjectMaker alloc] init];
        NSArray *tmp = [responseObject valueForKeyPath:@"response"];
        NSArray *objects = [fabric convertToCategories:tmp];
        [[ModelManager sharedManager].categories addObjectsFromArray:objects];
        
    } FailBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"Error response: %@",errorResponse);
    } andParameters:nil];
}

-(NSDictionary *)transformToDictionary:(NSArray *)objects
{
     NSMutableDictionary *result = [NSMutableDictionary dictionary];
     for(Venue *venue in objects)
     {
         NSMutableArray *tmp = [self.tableData objectForKey:venue.name];
         if(!tmp)
         {
            tmp = [NSMutableArray array];
         }
         [tmp addObject:venue];
         [result setValue:tmp forKey:venue.name];
     }
     return [NSDictionary dictionaryWithDictionary:result];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate and DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableData.allKeys.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [self.tableData.allKeys objectAtIndex:section];
    return [[self.tableData objectForKey:key] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *testKey = [self.tableData.allKeys objectAtIndex:section];
    Venue *testItem = [[self.tableData objectForKey:testKey] objectAtIndex:0];
    
    TableHeader *view =[[[NSBundle mainBundle]loadNibNamed:@"TableHeader" owner:nil options:nil]objectAtIndex:0];
    [view initWithCategory:testItem.category];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self configureVenueCell:indexPath];
}

#pragma mark - configuring cells

-(VenueCell *)configureVenueCell:(NSIndexPath *)indexPath
{
    VenueCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"venueCell" forIndexPath:indexPath];
    NSString *key = [self.tableData.allKeys objectAtIndex:indexPath.section];
    Venue *item = [[self.tableData objectForKey:key] objectAtIndex:indexPath.row];
    [cell initWithVenue:item];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.delegate = self;
    
    return cell;
}

@end

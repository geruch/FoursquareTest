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
#import "FTLoadingScreen.h"

#import "LocationManager.h"
#import "FTLocationManagerInterface.h"

#import <CoreLocation/CoreLocation.h>

@interface ViewController () <FTLocationManagerInterface>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FTLoadingScreen *loadingScreen;
@property (nonatomic, strong) NSDictionary *tableData;
@property (nonatomic, strong) LocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showLoader];
    
    self.locationManager = [[LocationManager alloc] init];
    self.locationManager.eventHandler = self;
    [self.locationManager launchManager:self];
    
    [self configureView];
    
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
    NSString *userLocation;
    if(!self.locationManager.currentLocation)
    {
        userLocation = @"37.7858,-122.406";
    }
    else
    {
        userLocation = [NSString stringWithFormat:@"%f,%f",self.locationManager.currentLocation.coordinate.latitude,self.locationManager.currentLocation.coordinate.longitude];
    }
    
    [[NetworkManager sharedHttpClient] getNearbyVenuesWithLocation:userLocation SuccessBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSLog(@"%@", responseObject);
        
        ObjectMaker *fabric = [[ObjectMaker alloc] init];
        NSArray *tmp = [[responseObject valueForKeyPath:@"response.groups.items"] objectAtIndex:0];
        NSArray *objects = [fabric convertToObjects:tmp];
        
        self.tableData = [self transformToDictionary:objects];
        [self.tableView reloadData];
        [self hideLoader];
        
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

-(void)showLoader
{
    self.loadingScreen = [[[NSBundle mainBundle]loadNibNamed:@"FTLoadingScreen" owner:nil options:nil] objectAtIndex:0];
    self.loadingScreen.frame = self.view.frame;
//    [self.loadingScreen init];
    [self.view addSubview:self.loadingScreen];
    [self.loadingScreen startLoadingIndication];
}

-(void)hideLoader
{
    [self.loadingScreen stopLoadingIndication];
    [self.loadingScreen removeFromSuperview];
}

-(NSDictionary *)transformToDictionary:(NSArray *)objects
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for(Venue *venue in objects)
    {
        NSMutableArray *tmp = [result objectForKey:venue.category.name];
        if(!tmp)
        {
           tmp = [NSMutableArray array];
        }

        [tmp addObject:venue];
        [result setValue:tmp forKey:venue.category.name];
         
    }
    
    [self sortValuesInDictionary:result];
    
    return [NSDictionary dictionaryWithDictionary:result];
}

-(NSMutableDictionary *)sortValuesInDictionary:(NSMutableDictionary *)dictionary
{
    for(NSString *key in dictionary.allKeys)
    {
        NSMutableArray *values = [dictionary objectForKey:key];
        if(values.count>1)
        {
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"location.distance" ascending:YES];
            [values sortUsingDescriptors:@[sort]];
        }
    }
    return dictionary;
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [self.tableData.allKeys objectAtIndex:section];
    return [[self.tableData objectForKey:key] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *testKey = [self.tableData.allKeys objectAtIndex:section];
    Venue *testItem = [[self.tableData objectForKey:testKey] objectAtIndex:0];
    
    TableHeader *view = [[[NSBundle mainBundle]loadNibNamed:@"TableHeader" owner:nil options:nil]objectAtIndex:0];
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

#pragma mark - FTLocationManagerInterface

-(void)updateUserLocation
{
    [self collectVenuesData];
}

@end

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
#import "FTShowMoreCell.h"
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
@property (nonatomic, strong) NSDictionary *addButtonsForSections;
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
    [self.tableView registerNib:[UINib nibWithNibName:@"FTShowMoreCell" bundle:nil] forCellReuseIdentifier:@"showMoreCell"];
    
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
        self.addButtonsForSections = [self configureSectionsButtons];
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

-(void)loadMoreVenuesWithCategory:(Category *)category forIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *userLocation = [NSString stringWithFormat:@"%f,%f",self.locationManager.currentLocation.coordinate.latitude,self.locationManager.currentLocation.coordinate.longitude];
    
    [[NetworkManager sharedHttpClient] getMoreVenuesWithLocation:userLocation category:category SuccessBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        ObjectMaker *fabric = [[ObjectMaker alloc] init];
        NSArray *tmp = [responseObject valueForKeyPath:@"response.venues"];
        NSArray *objects = [fabric convertToAdditionalObjects:tmp];
        self.tableData = [self injectObjectsToDictionary:objects forKey:category.name];
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndex:indexPath.section];
//        [self.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationBottom];
        [self.tableView beginUpdates];
            [self.tableView deleteSections:sectionToReload withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView insertSections:sectionToReload withRowAnimation:UITableViewRowAnimationBottom];
        [self.tableView endUpdates];
        
    } FailBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"Error response: %@",errorResponse);
    } andParameters:nil];
}

-(NSDictionary *)configureSectionsButtons
{
    NSMutableDictionary *tmp = [NSMutableDictionary dictionary];
    for(int i=0;i<self.tableData.allKeys.count;i++)
    {
        [tmp setValue:[NSNumber numberWithBool:YES] forKey:self.tableData.allKeys[i]];
    }
    
    return [NSDictionary dictionaryWithDictionary:tmp];
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

-(NSDictionary *)injectObjectsToDictionary:(NSArray *)objects forKey:(NSString *)key
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:self.tableData];
    NSMutableArray *tmp = [result objectForKey:key];
    [tmp removeAllObjects];
    [tmp addObjectsFromArray:objects];
    [self sortValuesInArray:tmp];
    return [NSDictionary dictionaryWithDictionary:result];
}

-(NSMutableDictionary *)sortValuesInDictionary:(NSMutableDictionary *)dictionary
{
    for(NSString *key in dictionary.allKeys)
    {
        NSMutableArray *values = [dictionary objectForKey:key];
        if(values.count>1)
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
    NSArray *tmp = [NSArray arrayWithArray:[self.tableData objectForKey:key]];
    if([[self.addButtonsForSections objectForKey:key] boolValue])
    {
        return tmp.count + 1;
    }
    else
    {
        return tmp.count;
    }
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
    if(indexPath.row < [[self.tableData objectForKey:[self.tableData.allKeys objectAtIndex:indexPath.section]] count])
    {
        return [self configureVenueCell:indexPath];
    }
    else
    {
        return [self configureShowMoreCell:indexPath];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *key = [self.tableData.allKeys objectAtIndex:indexPath.section];
    NSArray *sectionItems = [self.tableData objectForKey:key];
    if(indexPath.row == [sectionItems count])
    {
        [self loadMoreVenuesWithCategory:[[sectionItems firstObject] category] forIndexPath:indexPath];
        NSMutableDictionary *tmp = [NSMutableDictionary dictionaryWithDictionary:self.addButtonsForSections];
        [tmp setValue:[NSNumber numberWithBool:NO] forKey:key];
        self.addButtonsForSections = [NSDictionary dictionaryWithDictionary:tmp];
    }

}

#pragma mark - configuring cells

-(UITableViewCell *)configureVenueCell:(NSIndexPath *)indexPath
{
    VenueCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"venueCell" forIndexPath:indexPath];
    NSString *key = [self.tableData.allKeys objectAtIndex:indexPath.section];
    Venue *item = [[self.tableData objectForKey:key] objectAtIndex:indexPath.row];
    [cell initWithVenue:item];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.delegate = self;
    
    return cell;
}

-(UITableViewCell *)configureShowMoreCell:(NSIndexPath *)indexPath
{
    FTShowMoreCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"showMoreCell"forIndexPath:indexPath];
    return cell;
}

#pragma mark - FTLocationManagerInterface

-(void)updateUserLocation
{
    [self collectVenuesData];
}

@end

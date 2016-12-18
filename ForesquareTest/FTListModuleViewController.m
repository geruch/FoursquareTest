//
//  ViewController.m
//  ForesquareTest
//
//  Created by Команда Complex Systems on 06.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTListModuleViewController.h"
#import "FTNetworkManager.h"
#import "FTObjectMaker.h"
#import "FTVenue.h"
#import "FTVenueCell.h"
#import "FTShowMoreCell.h"
#import "FTListModelManager.h"
#import "FTTableHeader.h"
#import "FTLoadingScreen.h"

#import "FTLocationManager.h"
#import "FTLocationManagerInterface.h"

#import <CoreLocation/CoreLocation.h>

@interface FTListModuleViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FTLoadingScreen *loadingScreen;
@property (nonatomic, strong) NSDictionary *tableData;
@property (nonatomic, strong) NSDictionary *baseViewData;
@property (nonatomic, strong) NSDictionary *addButtonsForSections;
@property (nonatomic, strong) NSArray *categories;

@end

@implementation FTListModuleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showLoader];
    [self.eventHandler updateLocation];
    
    [self configureView];
    
//    [self.eventHandler collectVenueCategories];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.tableData.allKeys.count>0)
    {
        [self applyFilterToData];
        [self reloadEntries];
    }
}

- (void)configureView
{
    UIBarButtonItem *selectCategory = [[UIBarButtonItem alloc] initWithTitle:@"SEL"
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(didTapCategoryButton:)];
    
//    UIBarButtonItem *changeLocation = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
//                                                                                target:self
//                                                                                action:@selector(didTapLoactionButton:)];
    
    self.navigationItem.rightBarButtonItem = selectCategory;
//    self.navigationItem.leftBarButtonItem = changeLocation;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FTVenueCell" bundle:nil] forCellReuseIdentifier:@"venueCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FTShowMoreCell" bundle:nil] forCellReuseIdentifier:@"showMoreCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    
    self.tableData = [NSDictionary dictionary];
}

- (void)showListData:(NSDictionary *)data
{
    self.tableData = data;
    self.baseViewData = [NSDictionary dictionaryWithDictionary:data];
    self.categories = [NSArray arrayWithArray:[FTListModelManager sharedManager].categories];
    
    self.addButtonsForSections = [self configureSectionsButtons];

    [self reloadEntries];
    [self hideLoader];
}

-(void)applyFilterToData
{
    NSMutableDictionary *tmp = [NSMutableDictionary dictionaryWithDictionary:self.baseViewData];
    for(NSString *key in [FTListModelManager sharedManager].filter.allKeys)
    {
        if(![[[FTListModelManager sharedManager].filter objectForKey:key] boolValue])
        {
            [tmp removeObjectForKey:key];
        }
    }
    self.tableData = [NSDictionary dictionaryWithDictionary:tmp];
    
    NSMutableArray *newCategories = [NSMutableArray arrayWithArray:[FTListModelManager sharedManager].categories];
    for(FTCategory *category in [FTListModelManager sharedManager].categories)
    {
        if(![self.tableData.allKeys containsObject:category.name])
        {
            [newCategories removeObject:category];
        }
    }
    self.categories = [NSArray arrayWithArray:newCategories];
}

- (void)insertAdditionalVenues:(NSArray *)tmp forIndexPath:(NSIndexPath *)indexPath
{
    self.tableData = [self injectObjects:tmp
                            toDictionary:self.tableData
                                  forKey:[self.tableData.allKeys objectAtIndex:indexPath.section]];
    
    self.baseViewData = [self injectObjects:tmp
                            toDictionary:self.baseViewData
                                  forKey:[self.baseViewData.allKeys objectAtIndex:indexPath.section]];
    
    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndex:indexPath.section];
    [self.tableView beginUpdates];
        [self.tableView deleteSections:sectionToReload withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView insertSections:sectionToReload withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
}


-(NSDictionary *)injectObjects:(NSArray *)objects
                  toDictionary:(NSDictionary *)dictionary
                        forKey:(NSString *)key
{
//    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:self.tableData];
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    NSMutableArray *tmp = [result objectForKey:key];
    if(tmp==[NSNull null])
    {
        tmp = [NSMutableArray array];
    }
    for(FTVenue *object in objects)
    {
        BOOL check = [self isContainVenue:object inArray:tmp];
        if(!check)
        {
            [tmp addObject:object];
        }
    }
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"location.distance" ascending:YES];
    [tmp sortUsingDescriptors:@[sort]];
    
    [result setObject:tmp forKey:key];
    
    return [NSDictionary dictionaryWithDictionary:result];
}

- (BOOL)isContainVenue:(FTVenue *)venue inArray:(NSMutableArray *)array
{
    BOOL result = NO;
    
    for(FTVenue *item in array)
    {
        if([item.venueId isEqualToString:venue.venueId])
        {
            result = YES;
            break;
        }
    }
    
    return result;
}

- (void)reloadEntries
{
    [self.tableView reloadData];
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
    [self.view addSubview:self.loadingScreen];
    [self.loadingScreen startLoadingIndication];
}

-(void)hideLoader
{
    [self.loadingScreen stopLoadingIndication];
    [self.loadingScreen removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTapCategoryButton:(id)sender
{
    [self.eventHandler selectCategory];
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
    if([self.tableData objectForKey:key]!=[NSNull null])
    {
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
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    NSString *testKey = [self.tableData.allKeys objectAtIndex:section];
//    FTVenue *testItem = [[self.tableData objectForKey:testKey] objectAtIndex:0];
    FTCategory *category = [self.categories objectAtIndex:section];
    
    FTTableHeader *view = [[[NSBundle mainBundle]loadNibNamed:@"FTTableHeader" owner:nil options:nil]objectAtIndex:0];
    [view initWithCategory:category];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *sectionItems = [self.tableData objectForKey:[self.tableData.allKeys objectAtIndex:indexPath.section]];
    if(sectionItems!=[NSNull null] && indexPath.row < sectionItems.count)
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
    if(sectionItems==[NSNull null] || indexPath.row == sectionItems.count)
    {
        NSMutableDictionary *tmp = [NSMutableDictionary dictionaryWithDictionary:self.addButtonsForSections];
        [tmp setValue:[NSNumber numberWithBool:NO] forKey:key];
        self.addButtonsForSections = [NSDictionary dictionaryWithDictionary:tmp];
        [self.eventHandler loadAdditionalVenuesWithCategory:[self.categories objectAtIndex:indexPath.section]
                                                        forIndexPath:indexPath];
    }

}

#pragma mark - configuring cells

-(UITableViewCell *)configureVenueCell:(NSIndexPath *)indexPath
{
    FTVenueCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"venueCell" forIndexPath:indexPath];
    NSString *key = [self.tableData.allKeys objectAtIndex:indexPath.section];
    FTVenue *item = [[self.tableData objectForKey:key] objectAtIndex:indexPath.row];
    [cell initWithVenue:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.delegate = self;
    
    return cell;
}

-(UITableViewCell *)configureShowMoreCell:(NSIndexPath *)indexPath
{
    FTShowMoreCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"showMoreCell"forIndexPath:indexPath];
    return cell;
}

@end

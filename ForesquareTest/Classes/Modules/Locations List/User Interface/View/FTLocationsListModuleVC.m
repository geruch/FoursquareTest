//
//  FTLocationsListModuleVC.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 19.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTLocationsListModuleVC.h"
#import "FTLocationItemCell.h"
#import "FTLocation.h"

@interface FTLocationsListModuleVC ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic) NSInteger selectedIndex;

@end

@implementation FTLocationsListModuleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    [self.eventHandler getLocationsList];
}

- (void)configureView
{
    self.navigationItem.title = @"Select Location";
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                              target:self
                                                                              action:@selector(didTapSaveButton:)];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(didTapCancelButton:)];
    
    self.navigationItem.rightBarButtonItem = saveItem;
    self.navigationItem.leftBarButtonItem = cancelItem;

    
    [self.tableView registerNib:[UINib nibWithNibName:@"FTLocationItemCell" bundle:nil] forCellReuseIdentifier:@"locationItemCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)didTapSaveButton:(id)sender
{
    [self.eventHandler saveNewLocation:self.selectedIndex];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didTapCancelButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - FTLocationsListInterface

- (void)updateViewWithData:(NSArray *)locations index:(NSInteger)index
{
    self.locations = locations;
    self.selectedIndex = index;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate and DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.locations.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self configureCategorySelectionCell:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path
{
    [tableView deselectRowAtIndexPath:path animated:YES];
    
    FTLocationItemCell *cell = [tableView cellForRowAtIndexPath:path];
    
    self.selectedIndex = path.row;
    
//    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
//    {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    else
//    {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
    [self.tableView reloadData];
}

- (UITableViewCell *)configureCategorySelectionCell:(NSIndexPath *)indexPath
{
    
    FTLocation *location = [[FTLocation alloc] init];
    if (indexPath.row == 0)
    {
        location.address = @"Use current geoposition";
    }
    else
    {
        location = [self.locations objectAtIndex:indexPath.row-1];
    }
    
    FTLocationItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"locationItemCell" forIndexPath:indexPath];
    
    [cell initWithTitle:location.address coordinates:location.coordinate];
    
    if(indexPath.row == self.selectedIndex)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

@end

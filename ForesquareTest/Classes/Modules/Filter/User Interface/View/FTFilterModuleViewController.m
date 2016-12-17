//
//  FTFilterModuleViewController.m
//  ForesquareTest
//
//  Created by Andrew Gerashenko on 16.12.16.
//  Copyright © 2016 Команда Complex Systems. All rights reserved.
//

#import "FTFilterModuleViewController.h"
#import "FTListModelManager.h"
#import "FTCategory.h"
#import "FTCategoryCell.h"

@interface FTFilterModuleViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *tableData;
@property (nonatomic, strong) NSMutableDictionary *filterData;
@property (nonatomic) NSInteger counter;

@end

@implementation FTFilterModuleViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableData = [NSMutableDictionary dictionary];
    self.filterData = [NSMutableDictionary dictionary];
    
    [self configureView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.counter = self.tableData.allKeys.count;
    
//    [self.eventHandler updateView];
}


- (void)configureView
{
    self.navigationItem.title = @"Select Categories";
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(didTapAddButton:)];
    
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                             target:self
                                                                             action:@selector(didTapDeleteButton:)];
    
    self.navigationItem.rightBarButtonItem = addItem;
    self.navigationItem.leftBarButtonItem = deleteItem;
    
    NSMutableArray *categories = [[FTListModelManager sharedManager] categories];
    for(FTCategory *item in categories)
    {
        [self.tableData setObject:item forKey:item.name];
        [self.filterData setObject:[NSNumber numberWithBool:YES] forKey:item.name];
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FTCategoryCell" bundle:nil] forCellReuseIdentifier:@"categoryCell"];
//
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    
    self.tableView.allowsMultipleSelection = YES;
}


- (void)didTapAddButton:(id)sender
{
//    [self.eventHandler addNewEntry];
}

- (void)didTapDeleteButton:(id)sender
{
//    self.tableView.allowsMultipleSelectionDuringEditing = YES;
}

- (void)showNoContentMessage
{
    self.tableView.hidden = YES;
}


- (void)reloadEntries
{
    [self.tableView reloadData];
}


#pragma mark - UITableViewDelegate and DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableData.allKeys.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.allKeys.count;
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

    FTCategoryCell *cell = [tableView cellForRowAtIndexPath:path];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        if(self.counter>1)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self.filterData setObject:[NSNumber numberWithBool:NO] forKey:cell.name];
            self.counter--;
        }
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.filterData setObject:[NSNumber numberWithBool:YES] forKey:cell.name];
        self.counter++;
    }
}

- (UITableViewCell *)configureCategorySelectionCell:(NSIndexPath *)indexPath
{
    FTCategoryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
    
    FTCategory *category = [self.tableData objectForKey:[self.tableData.allKeys objectAtIndex:indexPath.row]];
    [cell initWithCategory:category];
    if([[self.filterData objectForKey:category.name] boolValue])
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

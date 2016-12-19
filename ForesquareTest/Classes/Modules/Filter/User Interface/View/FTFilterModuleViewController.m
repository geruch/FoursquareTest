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
@property (nonatomic, strong) NSMutableArray *categories;
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
    self.filterData = [NSMutableDictionary dictionaryWithDictionary:[FTListModelManager sharedManager].filter];
    
    [self configureView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self countSelectedCategories];
}

-(void)countSelectedCategories
{
    NSInteger result = 0;
    for(NSString *key in self.filterData.allKeys)
    {
        if([[self.filterData objectForKey:key] boolValue])
        {
            result++;
        }
    }
    
    self.counter = result;
}

- (void)configureView
{
    self.navigationItem.title = @"Select Categories";
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                             target:self
                                                                             action:@selector(didTapSaveButton:)];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                             target:self
                                                                             action:@selector(didTapCancelButton:)];
    
    self.navigationItem.rightBarButtonItem = saveItem;
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    self.categories = [FTListModelManager sharedManager].categories;
    
    for(FTCategory *item in self.categories)
    {
        [self.tableData setObject:item forKey:item.name];
    }
    
    if(self.filterData.allKeys.count == 0)
    {
        for(FTCategory *item in self.categories)
        {
            [self.filterData setObject:[NSNumber numberWithBool:YES] forKey:item.name];
        }
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FTCategoryCell" bundle:nil] forCellReuseIdentifier:@"categoryCell"];
//
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    
    self.tableView.allowsMultipleSelection = YES;
}


- (void)didTapSaveButton:(id)sender
{
    [self.eventHandler saveCategoriesFilter:self.filterData];
    [FTListModelManager sharedManager].filter = [NSMutableDictionary dictionaryWithDictionary:self.filterData];
}

- (void)didTapCancelButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showNoContentMessage
{
    self.tableView.hidden = YES;
}

- (void)reloadEntries
{
    [self.tableView reloadData];
}

-(void)dismissView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate and DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    
    NSString *key = [[self.categories objectAtIndex:indexPath.row] name];
    FTCategory *category = [self.tableData objectForKey:key];
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

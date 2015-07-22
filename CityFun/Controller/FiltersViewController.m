//
//  FiltersViewController.m
//  Yelp
//
//  Created by Vincent Lai on 6/23/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "FiltersViewController.h"
#import "CheckBoxCell.h"
#import "ExpandCell.h"
#import <SSKeychain.h>
#import "LoginViewController.h"
#import "UserModel.h"

@interface FiltersViewController ()<UITableViewDataSource, UITableViewDelegate, CheckBoxCellDelegate>

@property (nonatomic, readonly) NSDictionary *filters;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *distances;
@property (nonatomic, strong) NSArray *gpsMethods;
@property (nonatomic, strong) NSDictionary *selectedDistance;
@property (nonatomic, strong) NSDictionary *selectedGPSMethod;

@property (nonatomic) BOOL distanceExpanded;
@property (nonatomic) BOOL gpsExpanded;

- (void)initArrays;


@end

@implementation FiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self) {
        [self initArrays];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //定義navigation 左右按鈕 同時設定callback function
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(onApplyButton)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CheckBoxCell" bundle:nil] forCellReuseIdentifier:@"CheckBoxCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpandCell" bundle:nil] forCellReuseIdentifier:@"ExpandCell"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.selectedDistance = [defaults objectForKey:@"filtersDistance"];
    self.selectedGPSMethod = [defaults objectForKey:@"filtersGPSMethod"];

    
    if (!self.selectedDistance) {
        self.selectedDistance = self.distances[0];
    }
    if (!self.selectedGPSMethod) {
        self.selectedGPSMethod = self.gpsMethods[0];
    }
    

}

//定義table view每個section的數量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case SECTION_DISTANCE:
            if (self.distanceExpanded)  return self.distances.count;
            return 1;
        case SECTION_GPS:
            if (self.gpsExpanded)  return self.gpsMethods.count;
            return 1;
        case 2:
            return 1;
        default:
            return 0;
    }
}

//定義每個cell的內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //分類一 Offering a Deal 的描述
    if(indexPath.section == SECTION_DISTANCE)
    {
        if (!self.distanceExpanded) {
            ExpandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExpandCell"];
            cell.titleLabel.text = self.selectedDistance[@"name"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            CheckBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckBoxCell"];
            cell.titleLabel.text = self.distances[indexPath.row][@"name"];
            cell.on = [self.selectedDistance isEqualToDictionary:self.distances[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }
    }
    else if (indexPath.section == 2)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"signout"];
        cell.textLabel.text = @"登出";
        return cell;
    }
    else
    {
        if (!self.gpsExpanded) {
            ExpandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExpandCell"];
            cell.titleLabel.text = self.selectedGPSMethod[@"name"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            CheckBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckBoxCell"];
            cell.titleLabel.text = self.gpsMethods[indexPath.row][@"name"];
            cell.on = [self.selectedGPSMethod isEqualToDictionary:self.gpsMethods[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == SECTION_DISTANCE)
    {
        if (!self.distanceExpanded) {
            self.distanceExpanded = YES;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SECTION_DISTANCE] withRowAnimation:UITableViewRowAnimationNone];
            
        } else {
            CheckBoxCell *cell = (CheckBoxCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.on = YES;
            [self checkBoxCell:cell didUpdateValue:YES];
        }
    }
    else if (indexPath.section == SECTION_GPS)
    {
        if (!self.gpsExpanded) {
            self.gpsExpanded = YES;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SECTION_GPS] withRowAnimation:UITableViewRowAnimationNone];
            
        } else {
            CheckBoxCell *cell = (CheckBoxCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.on = YES;
            [self checkBoxCell:cell didUpdateValue:YES];
        }
    }
    else if (indexPath.section == 2)
    {   //sign out
        NSString *uid = [UserModel getUserClient].currentUser.userId;
        [SSKeychain deletePasswordForService:@"cityfun" account:uid];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginView = [sb instantiateViewControllerWithIdentifier:@"LoginView"];
        [self.navigationController showDetailViewController:loginView sender:self];
    }
}


- (void)checkBoxCell:(CheckBoxCell *)cell didUpdateValue:(BOOL)value {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if (indexPath.section == SECTION_DISTANCE)
    {
        if (value) {
            self.selectedDistance = self.distances[indexPath.row];
        
            for (NSInteger row = 0; row < 5; row++) {
                if (row != indexPath.row) {
                    CheckBoxCell *cell = (CheckBoxCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:indexPath.section]];
                    [cell setOn:NO];
                }
            }
            self.distanceExpanded = NO;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SECTION_DISTANCE] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            cell.on = YES;
            self.distanceExpanded = NO;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SECTION_DISTANCE] withRowAnimation:UITableViewRowAnimationFade];
        }
    } else if (indexPath.section == SECTION_GPS){
        if (value) {
            self.selectedGPSMethod = self.gpsMethods[indexPath.row];
            
            for (NSInteger row = 0; row < 3; row++) {
                if (row != indexPath.row) {
                    CheckBoxCell *cell = (CheckBoxCell *)[self.tableView cellForRowAtIndexPath:
                                                          [NSIndexPath indexPathForRow:row inSection:indexPath.section]];
                    [cell setOn:NO];
                }
            }
            
            self.gpsExpanded = NO;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SECTION_GPS] withRowAnimation:UITableViewRowAnimationNone];
            
        } else {
            self.selectedGPSMethod = nil;
        }
    }
}

//新增filter的query string
- (NSDictionary *)filters {
    NSMutableDictionary *filters = [NSMutableDictionary dictionary];
    if (self.selectedDistance &&
        ![self.selectedDistance isEqualToDictionary:self.distances[0]])  // don't set filter for "best match"
    {
        [filters setObject:self.selectedDistance[@"value"] forKey:@"distance"];
    }
    
    if (self.selectedGPSMethod) {
        [filters setObject:self.selectedGPSMethod[@"value"] forKey:@"gps"];
    }
    
    return filters;
}

//Apply button的call back function
- (void)onApplyButton{
    [self.delegate filtersViewController:self didChangeFilters:self.filters];
    [self saveFilters];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MapFilterChange" object:nil];
}

- (void)saveFilters {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.selectedDistance forKey:@"filtersDistance"];
    [defaults setObject:self.selectedGPSMethod forKey:@"filtersGPSMethod"];
    
    [defaults synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//設定有多少分類
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

//每個分類的標題名稱
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case SECTION_DISTANCE:
            return @"Distance";
        case SECTION_GPS:
            return @"GPS Model";
        default:
            return @"";
    }
}

- (void)initArrays {
    self.distances = @[
                       @{@"name" : @"300 meter", @"value" : @300},
                       @{@"name" : @"500 meter", @"value" : @500},
                       @{@"name" : @"800 meter", @"value" : @800},
                       @{@"name" : @"1000 meter", @"value" : @1000}
                       ];
    
    self.gpsMethods = @[
                         @{@"name" : @"Normal", @"value" : @0},
                         @{@"name" : @"Satellite", @"value" : @1},
                         @{@"name" : @"Terrain", @"value" : @2}
                         ];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

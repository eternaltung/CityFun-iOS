//
//  MainController.m
//  CityFun
//
//  Created by Shih-Ming Tung on 7/13/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "MainController.h"
#import <MBProgressHUD.h>
#import "AttractionsModel.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MainCollectionView.h"
#import "MapView.h"
#import "FiltersViewController.h"
#import <POP.h>
#import "DetailViewController.h"
#import "FavoriteTableView.h"

@interface MainController () <CLLocationManagerDelegate, MapViewDelegate, UISearchBarDelegate>
@property (strong, nonatomic) NSMutableArray *attractions;
@property (weak, nonatomic) IBOutlet UIView *MainView;
@property (nonatomic, strong) MainCollectionView *collectionView;
@property (nonatomic, strong) MapView *mapView;
@property (nonatomic, strong) FavoriteTableView *favoriteView;
@property (nonatomic, strong) UISearchBar *searchbar;
@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self addNavigationBarUI];
    self.collectionView = [[MainCollectionView alloc] initWithNibName:@"MainCollectionView" bundle:nil];
    self.mapView = [[MapView alloc] initWithNibName:@"MapView" bundle:nil];
    self.mapView.delegate = self;
    self.favoriteView = [[FavoriteTableView alloc] initWithNibName:@"FavoriteTableView" bundle:nil];
    
    [self displayView:self.mapView];
}

- (void)addNavigationBarUI
{
    self.searchbar = [[UISearchBar alloc] init];
    [self.searchbar setPlaceholder:@"search"];
    self.searchbar.text = @"";
    self.searchbar.delegate = self;
    self.navigationItem.titleView = self.searchbar;
    
    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(settingTap)];
    self.navigationItem.leftBarButtonItem = settingButton;
}

- (void)settingTap
{
    FiltersViewController *filterView = [[FiltersViewController alloc] initWithNibName:@"FiltersViewController" bundle:nil];
    [self.navigationController pushViewController:filterView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (IBAction)tabPress:(UIButton *)sender
{
    if ([sender.titleLabel.text  isEqual:@"List"])
    {       //switch to list view
        [self displayView:self.collectionView];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Map"])
    {       //switch to map view
        [self displayView:self.mapView];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Favorite"])
    {       //switch to favorite view
        [self displayView:self.favoriteView];
        //[self.navigationController pushViewController:self.favoriteView animated:YES];
    }
}

- (void)displayView:(UIViewController*)viewController
{
    viewController.view.frame = self.MainView.bounds;
    [self.MainView addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

- (void)MapView:(BOOL)didLoad
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)PushView:(AttractionsModel *)attraction
{
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithCollectionViewLayout:[PSUICollectionViewFlowLayout new]];
    detailViewController.attraction = attraction;
    [self.navigationController pushViewController:detailViewController animated:YES];
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

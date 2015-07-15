//
//  MainCollectionView.m
//  CityFun
//
//  Created by Shih-Ming Tung on 7/14/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "MainCollectionView.h"
#import "AttractionsModel.h"
#import "CollectionCell.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import <POP.h>

@interface MainCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *attractions;
@end

@implementation MainCollectionView
NSString *reuseID = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    UINib *nib = [UINib nibWithNibName:@"CollectionCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseID];
    self.attractions = [NSMutableArray new];
    [self filterData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MapFilterChange) name:@"MapFilterChange" object:nil];
}

- (void)MapFilterChange
{
    self.attractions = [NSMutableArray new];
    [self filterData];

}

- (void)filterData
{
    //get filter distance
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int distance = [defaults objectForKey:@"filtersDistance"] == nil ? 500 : [[[defaults objectForKey:@"filtersDistance"] valueForKey:@"value"] intValue];
    
    //filter distance
    for (AttractionsModel *data in [AttractionsModel getAttractions])
    {
        CLLocationDistance meters = [[AppDelegate getUserLocation] distanceFromLocation:[[CLLocation alloc] initWithLatitude:data.latitude longitude:data.longitude]];
        if (meters < distance)
        {
            [self.attractions addObject:data];
        }
    }
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.attractions.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    cell.attraction = self.attractions[indexPath.row];
    [cell setUIData];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return  UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(180, 200);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
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

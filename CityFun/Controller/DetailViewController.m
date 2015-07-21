//
//  DetailViewController.m
//  CityFun
//
//  Created by Sean Zeng on 7/14/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCell.h"
#import "DetailView.h"
#import "FXBlurView.h"
#import <ObjectiveFlickr.h>
#import "UserModel.h"

@interface DetailViewController () <OFFlickrAPIRequestDelegate>

@property (nonatomic, strong) OFFlickrAPIContext *context;
@property (nonatomic, strong) OFFlickrAPIRequest *request;

@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, strong) NSArray *photosDict;
@property (assign, nonatomic) BOOL isFavorite;
@property (strong, nonatomic) UserModel *favoriteData;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.cellCount = 10;
    [self.collectionView registerClass:[DetailCell class] forCellWithReuseIdentifier:@"DetailCell"];
    //[self.collectionView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellWithReuseIdentifier:@"DetailCell"];
    
    self.collectionView.backgroundColor = [UIColor blackColor];
    
    self.context = [[OFFlickrAPIContext alloc] initWithAPIKey:@"a3909c74c682bb64b57837d96d4f1c7e" sharedSecret:@"0307d41420c1146e"];
    self.request = [[OFFlickrAPIRequest alloc] initWithAPIContext:self.context];
    [self.request setDelegate:self];
    //[self.request callAPIMethodWithGET:@"flickr.photos.getRecent" arguments:[NSDictionary dictionaryWithObjectsAndKeys:@"1", @"per_page", nil]];
    [self.request callAPIMethodWithGET:@"flickr.photos.search" arguments:[NSDictionary dictionaryWithObjectsAndKeys:@"10", @"per_page", @"台北101", @"text", @"interestingness-desc", @"sort", @"", @"tags", nil]];
    
    DetailView *detailView = [[[NSBundle mainBundle] loadNibNamed:@"DetailView" owner:self options:nil] objectAtIndex:0];
    [detailView setFrame:self.view.bounds];
    //[detailView setFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    [self.view addSubview:detailView];
    
    [detailView.tapGestureRecognizer addTarget:self action:@selector(onOpenTap:)];
    detailView.attraction = self.attraction;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self addFavoriteButton];
}

- (void)addFavoriteButton
{
    [UserModel getFavorites:^(NSMutableArray *favorites)
    {
        self.isFavorite = NO;
        for (UserModel *user in favorites)
        {
            if (user.placeID == self.attraction._id)
            {
                self.isFavorite = YES;
                self.favoriteData = user;
                break;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:self.isFavorite ? @"favorite" : @"unfavorite"] style:UIBarButtonItemStylePlain target:self action:@selector(FavoriteTap)];
        });
    }];
}

- (void)FavoriteTap
{
    if (self.isFavorite)
    {    //do unfavorite
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"unfavorite"];
        [UserModel updateFavorites:0 dataID:self.favoriteData.id isadd:NO complete:^(UserModel *user) {
            self.favoriteData = nil;
        }];
    }
    else
    {   //favorite
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"favorite"];
        [UserModel updateFavorites:self.attraction._id dataID:@"" isadd:YES complete:^(UserModel *user) {
            self.favoriteData = user;
        }];
    }
    self.isFavorite = !self.isFavorite;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self.request cancel];
    self.request = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - OFFlickrAPIRequestDelegate methods
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary {
    //NSLog(@"%@", inResponseDictionary);
    
    if (inResponseDictionary != nil) {
        self.photosDict = [inResponseDictionary valueForKeyPath:@"photos.photo"];
        self.cellCount = self.photosDict.count;
        [self.collectionView reloadData];
    }
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError {
    //NSLog(@"%@", inError);
}

#pragma mark - PSTCollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.cellCount;
}

#pragma mark - PSTCollectionViewDelegate methods

- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%zd", self.cellCount);
    
    if (self.photosDict == nil || indexPath.row >= self.cellCount) {
        return nil;
    }
    
    DetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailCell" forIndexPath:indexPath];
    
    NSDictionary *photoDict = [self.photosDict objectAtIndex:indexPath.row];
    
    //NSLog(@"%@", photoDict);
    
    cell.photoURL = [self.context photoSourceURLFromDictionary:photoDict size:OFFlickrLargeSize];

    NSLog(@"%@", cell.photoURL);
    
    return cell;
}

#pragma mark - PSTCollectionViewDelegateFlowLayout methods

- (CGSize)collectionView:(PSUICollectionView *)collectionView layout:(PSUICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(180, 200);
}

- (CGFloat)collectionView:(PSUICollectionView *)collectionView layout:(PSUICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(PSUICollectionView *)collectionView layout:(PSUICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (UIEdgeInsets)collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - Private methods
- (void)onOpenTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    FXBlurView *fxBlurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    fxBlurView.blurRadius = 100;
    fxBlurView.dynamic = NO;
    fxBlurView.tintColor = [UIColor clearColor];
    
    fxBlurView.tag = 15;
    
    [self.view addSubview:fxBlurView];
    
    DetailView *detailFullView = [[[NSBundle mainBundle] loadNibNamed:@"DetailFullView" owner:self options:nil] objectAtIndex:0];
    [detailFullView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    detailFullView.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *closeTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCloseTap:)];
    [detailFullView addGestureRecognizer:closeTapGestureRecognizer];
    
    detailFullView.tag = 16;
    
    detailFullView.attraction = self.attraction;
    
    [self.view addSubview:detailFullView];
}

- (void)onCloseTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    UIView *view = [self.view viewWithTag:15];
    [view removeFromSuperview];
    
    view = [self.view viewWithTag:16];
    [view removeFromSuperview];
}

@end

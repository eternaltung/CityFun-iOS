//
//  CMFViewController.m
//  UICollectionGallery
//
//  Created by Tim on 05/04/2013.
//  Copyright (c) 2013 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMFViewController.h"
#import "CMFGalleryCell.h"
#import "AttractionsModel.h"

//for test
#import "FiltersViewController.h"

//for test
//#import "ViewController.h"

@interface CMFViewController ()<FiltersViewControllerDelegate>// for test
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic) int currentIndex;

@property (nonatomic, assign) long arrayIndex;

@end

@implementation CMFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //for test
    //ViewController *test = [[ViewController alloc] init];
    //[test fetchData];
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(onDismissButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(onShareButton)];
    
	// Do any additional setup after loading the view, typically from a nib.
    //[self initArray];
    [self setupCollectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UICollectionView methods

-(void)setupCollectionView {
    [self.collectionView registerClass:[CMFGalleryCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setCollectionViewLayout:flowLayout];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.imageArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CMFGalleryCell *cell = (CMFGalleryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    [cell setImageName:self.imageArray[indexPath.row]];
    [cell updateCell];
    
    self.arrayIndex = indexPath.row;
    
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.frame.size;
}

#pragma mark -
#pragma mark Rotation handling methods

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:
(NSTimeInterval)duration {

    // Fade the collectionView out
    [self.collectionView setAlpha:0.0f];
    
    // Suppress the layout errors by invalidating the layout
    [self.collectionView.collectionViewLayout invalidateLayout];
  
    // Calculate the index of the item that the collectionView is currently displaying
    CGPoint currentOffset = [self.collectionView contentOffset];    
    self.currentIndex = currentOffset.x / self.collectionView.frame.size.width;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  
    // Force realignment of cell being displayed
    CGSize currentSize = self.collectionView.bounds.size;
    float offset = self.currentIndex * currentSize.width;
    [self.collectionView setContentOffset:CGPointMake(offset, 0)];
    
    // Fade the collectionView back in
    [UIView animateWithDuration:0.125f animations:^{
        [self.collectionView setAlpha:1.0f];
    }];
    
}

- (void) initArray{
    
    self.imageArray = [[NSMutableArray alloc] init];
    
    for (AttractionsModel *data in [AttractionsModel getAttractions])
    {
        NSLog(@"test %@", data.file);
        [self.imageArray addObject:data.file];
        //break;
    }

    NSArray *array = [[NSArray alloc] initWithObjects:@"http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000848.jpg",
                      @"http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000340.jpg",
                      @"http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000721.jpg",
                      @"http://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D7/E150/F719/71eb4b56-f771-43bc-856c-2fb265a5cc6e.jpg",
                      nil];
    
    [self.imageArray addObjectsFromArray:array];
}


- (void)filtersViewController:(FiltersViewController *)filtersViewController didChangeFilters:(NSDictionary *)filters{
    
    NSLog(@"filters setting   %@", filters);
}

- (void)onFilterButton{
    FiltersViewController *vc = [[FiltersViewController alloc] init];
    
    vc.delegate = self;
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)onShareButton{
    NSString *message = @"Hello Taipei!!";
    
    //設定圖片的url位址
    NSURL *url = [NSURL URLWithString:self.imageArray[self.arrayIndex]];
    
    //使用NSData的方法將影像指定給UIImage
    UIImage *urlImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
    
    
    NSArray *postItems = @[message, urlImage];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:postItems
                                            applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)onDismissButton {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)setCurrentIndexPath:(NSInteger)currentIndexPath {
    _currentIndexPath = currentIndexPath;
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(animatePickerTimer:) userInfo:nil repeats:NO];
}

-(void)animatePickerTimer:(NSTimer *)timer;
{
    [self performSelectorOnMainThread:@selector(animatePicker) withObject:nil waitUntilDone:NO];
    
    //Not sure if this is required, since the timer does not repeat
    [timer invalidate];
}

-(void)animatePicker
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndexPath inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

@end

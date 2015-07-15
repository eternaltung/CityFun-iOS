//
//  MapView.m
//  CityFun
//
//  Created by Shih-Ming Tung on 7/14/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "MapView.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AttractionsModel.h"
#import <MBProgressHUD.h>
#import "UIImage+Resize.h"

@interface MapView () <CLLocationManagerDelegate, GMSMapViewDelegate>
@property (strong, nonatomic) NSMutableArray *attractions;
@property (strong, nonatomic) IBOutlet UIView *MapView;
@property (strong, nonatomic) GMSMapView *map;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *userLocation;
@property (nonatomic, strong) UIView *panoView;
@end

@implementation MapView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.attractions = [NSMutableArray new];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.panoView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 330, 150)];
}

//location update
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    self.userLocation = [locations lastObject];
    [manager stopUpdatingLocation];
    [self fetchData];
}

- (void)fetchData
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=36847f3f-deff-4183-a5bb-800737591de5"]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if (connectionError == nil)
         {
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             [AttractionsModel setCurrentData:[AttractionsModel arrayOfModelsFromDictionaries:dict[@"result"][@"results"]]];
             [self setMap];
         }
     }];
}

- (void)setMap
{
    //add google map
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.userLocation.coordinate.latitude longitude:self.userLocation.coordinate.longitude zoom:14];
    self.map = [GMSMapView mapWithFrame:self.MapView.bounds camera:camera];
    self.map.myLocationEnabled = YES;
    self.map.settings.myLocationButton = YES;
    self.map.settings.compassButton = YES;
    self.map.delegate = self;
    
    //draw circle on the map
    GMSCircle *circle = [GMSCircle circleWithPosition:self.userLocation.coordinate radius:900];
    circle.map = self.map;
    circle.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
    circle.strokeColor = [UIColor redColor];
    [self.MapView addSubview:self.map];
    
    //filter distance
    for (AttractionsModel *data in [AttractionsModel getAttractions])
    {
        CLLocationDistance meters = [self.userLocation distanceFromLocation:[[CLLocation alloc] initWithLatitude:data.latitude longitude:data.longitude]];
        if (meters < 900)
        {
            [self.attractions addObject:data];
        }
    }
    
    // create a marker
    for (AttractionsModel *data in self.attractions)
    {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.userData = data;
        marker.position = CLLocationCoordinate2DMake(data.latitude, data.longitude);
        marker.title = data.stitle;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.icon = [UIImage image:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:data.file]]] resize:CGSizeMake(30, 30)];
        marker.snippet = data.xbody;
        marker.map = self.map;
    }
    [self.delegate MapView:YES];
}

//tap map marker
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    AttractionsModel *attraction = marker.userData;
    
    //add street view
    GMSPanoramaView *panoView = [GMSPanoramaView panoramaWithFrame:self.panoView.bounds nearCoordinate:CLLocationCoordinate2DMake(attraction.latitude, attraction.longitude)];
    [self.panoView addSubview:panoView];
    [self.view addSubview:self.panoView];
    return NO;
}

//tap marker callout windows
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    AttractionsModel *attraction = marker.userData;
}

//remove street view
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self.panoView removeFromSuperview];
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

@end

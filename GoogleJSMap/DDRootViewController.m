//
//  DDRootViewController.m
//  GoogleJSMap
//
//  Created by lawn on 14-4-16.
//  Copyright (c) 2014年 lawn. All rights reserved.
//

#import "DDRootViewController.h"
#import "DDMapMarker.h"

@interface DDRootViewController ()<DDGoogleJSMapViewDelegate>

@property(nonatomic,strong) NSMutableArray      *markerList;

@property(nonatomic,strong) DDGoogleJSMapView   *mapView;

@end


@implementation DDRootViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
     
        self.title = @"google js地图";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.mapView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);

    NSArray *arr = [NSArray arrayWithObjects:@"添加1组标注",@"添加备选标注",@"清除所有标注", nil];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:arr];
    [segment addTarget:self action:@selector(segmentSwitched:) forControlEvents:UIControlEventValueChanged];
    segment.alpha = 1;
  
    if ([[UIDevice currentDevice].systemVersion doubleValue]>= 7.0) {
        segment.frame = CGRectMake(20, 70, 280, 40);
    }else{
        segment.frame = CGRectMake(20, 0, 280, 40);
    }
    
    [self.view addSubview:segment];
    
}


-(void)segmentSwitched:(id)sender{
    
    UISegmentedControl *control = (UISegmentedControl *)sender;
    
    if (control.selectedSegmentIndex == 0) {
        
        int x = arc4random() % 6 + 1;
        int y = arc4random() % 6 + 1;;
        
        DDMapMarker *marker = [[DDMapMarker alloc] init];
        marker.markerTitle = @"普通标注";
        marker.latitude = [NSString stringWithFormat:@"%.12f",32.221944444444+x*0.1];
        marker.longitude = [NSString stringWithFormat:@"%.12f",121.35361111111+y*0.1];
        
        [self.markerList addObject:marker];
        
        [self.mapView addMarkers:self.markerList];
        
    }else if(control.selectedSegmentIndex == 1){
    
        int x = arc4random() % 6 + 1;
        int y = arc4random() % 6 + 1;;
        
        DDMapMarker *marker = [[DDMapMarker alloc] init];
        marker.markerTitle = [NSString stringWithFormat:@"备选标注"];
        marker.latitude = [NSString stringWithFormat:@"%.12f",32.221944444444+x*0.1];
        marker.longitude = [NSString stringWithFormat:@"%.12f",121.35361111111+y*0.1];
        marker.markerType = @"1";
        
        [self.markerList addObject:marker];

        [self.mapView addMarkers:self.markerList];
     
    }else{
        
        [self.markerList removeAllObjects];
        
        [self.mapView clearMarkers];
    }
  

}

#pragma mark -
#pragma mark DDGoogleJSMapView
-(DDGoogleJSMapView *)mapView{
    
    if (!_mapView) {
        _mapView = [[DDGoogleJSMapView alloc]init];
        _mapView.markerList = self.markerList;
        _mapView.delegate = self;
        [self.view addSubview:_mapView];
    }
    return _mapView;
}

-(void)ddGoogleJSMapView:(DDGoogleJSMapView *)jsMapView index:(NSInteger)index{
    
    DDMapMarker *marker = [self.markerList objectAtIndex:index];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"您点击的是" message:marker.markerTitle delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    
    [alertView show];
}


#pragma mark -
#pragma mark markerList
-(NSMutableArray *)markerList{
    if (!_markerList) {
        _markerList = [[NSMutableArray alloc]init];
    }
    return _markerList;
}

@end

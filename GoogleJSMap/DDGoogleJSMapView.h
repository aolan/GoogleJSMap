//
//  DDGoogleJSMapView.h
//  GoogleJSMap
//
//  Created by lawn on 14-4-16.
//  Copyright (c) 2014年 lawn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol  DDGoogleJSMapViewDelegate;

@interface DDGoogleJSMapView : UIView

/**
 *	@brief	加载html页面
 */
@property(nonatomic,strong) UIWebView       *webMapView;

/**
 *	@brief	标注列表
 */
@property(nonatomic,strong) NSMutableArray  *markerList;

/**
 *	@brief	代理
 */
@property(nonatomic,assign)id<DDGoogleJSMapViewDelegate> delegate;

@end


@protocol DDGoogleJSMapViewDelegate <NSObject>

-(void)ddGoogleJSMapView:(DDGoogleJSMapView *)jsMapView index:(NSInteger)index;

@end
//
//  DDGoogleJSMapView+MapActionEx.h
//  GoogleJSMap
//
//  Created by lawn on 14-4-16.
//  Copyright (c) 2014年 lawn. All rights reserved.
//

#import "DDGoogleJSMapView.h"
#import <CoreLocation/CoreLocation.h>

@interface DDGoogleJSMapView (MapActionEx)

/**
 *  设置地图中心坐标与缩放比例(首先调用该方法)
 *
 *  @param coordinate 中心坐标
 *  @param zoom       缩放比例
 */
- (void)setMapCenter:(CLLocationCoordinate2D)coordinate zoom:(CGFloat)zoom;


/**
 *  在地图上添加标注(地图加载成功后，调用该方法添加标注)
 *
 *  @param markerList 标注列表
 */
-(void)addMarkers:(NSArray *)markerList;


/**
 *  在地图上添加标注(地图加载成功后，调用该方法添加标注)
 *
 *  @param markerList 标注列表(使用的时候将所有要展示的标注放在数组里，否则回调的index可能beyond bounds)
 *  @param isClear    在添加标注之前是否需要先清空图上现有的标注 [YES:清空，NO:不清空]
 */
-(void)addMarkers:(NSArray *)markerList needClearBefore:(BOOL)isClear;



/**
 *  清除地图上的标注
 *
 */
-(void)clearMarkers;


/**
 *  根据标注自适应展示区域和zoom
 *
 *  @param markerList 标注列表
 */
-(void)zoomToSpan:(NSArray *)markerList;


/**
 *  处理js回调
 *
 *  @param  url js回调的链接, 如"googleCtripMap://index=0"
 */
-(void)parseProtocol:(NSString *)url;


@end

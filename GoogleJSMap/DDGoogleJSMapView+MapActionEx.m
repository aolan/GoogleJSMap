//
//  DDGoogleJSMapView+MapActionEx.m
//  GoogleJSMap
//
//  Created by lawn on 14-4-16.
//  Copyright (c) 2014年 lawn. All rights reserved.
//

#import "DDGoogleJSMapView+MapActionEx.h"
#import "NSString+CTExtensions.h"
#import "DDMapMarker.h"
#import "JSONKit.h"

@implementation DDGoogleJSMapView (MapActionEx)

#pragma mark -
#pragma mark public Action

- (void)setMapCenter:(CLLocationCoordinate2D)coordinate zoom:(CGFloat)zoom {
    
    NSString *jsStr = [NSString stringWithFormat:@"setMapCenterAndZoom(%f,%f,%f)",coordinate.latitude,coordinate.longitude,zoom];
    
    [self.webMapView stringByEvaluatingJavaScriptFromString:jsStr];
}

-(void)clearMarkers{
    
    NSString *jsStr = @"clearMarker()";
    
    [self.webMapView stringByEvaluatingJavaScriptFromString:jsStr];
}


-(void)addMarkers:(NSArray *)markerList{
    
    [self clearMarkers];
    //一定要先展示可适区域，在打点
    [self zoomToSpan:markerList];
    
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:markerList.count];
    
    for (DDMapMarker *marker in markerList) {
        
        NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
        
        [jsonDict setObject:marker.markerIndex forKey:@"markerIndex"];
        [jsonDict setObject:marker.latitude forKey:@"latitude"];
        [jsonDict setObject:marker.longitude forKey:@"longitude"];
        [jsonDict setObject:marker.markerTitle forKey:@"markerTitle"];
        [jsonDict setObject:marker.markerType forKey:@"markerType"];
        
        NSString *jsParam = [jsonDict JSONString];
        
        if (jsParam.length  > 0) {
            
            [arr addObject:jsParam];
        }
    }
    
    if (arr.count > 0) {
        
        NSString *string = [[arr valueForKey:@"description"]componentsJoinedByString:@",,,,,.,,,,,"];
        
        NSString *jsStr = [NSString stringWithFormat:@"addMarker(\"%@\")",[string stringByCFURLEncoding]];
        
        [self.webMapView stringByEvaluatingJavaScriptFromString:jsStr];
    }
    
}

-(void)addMarkers:(NSArray *)markerList needClearBefore:(BOOL)isClear{
    
    //展示标注时先清除已存在的标注
    if (isClear) {
        
        [self.markerList removeAllObjects];
        
    }
    
    [self.markerList addObjectsFromArray:markerList];
    
    [self addMarkers:self.markerList];
}


-(void)zoomToSpan:(NSArray *)markerList{
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    
    for(DDMapMarker *marker in markerList)
    {
        if (marker.latitude == 0 || marker.longitude == 0) {
            continue;
        }
        
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, [marker.longitude doubleValue]);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, [marker.latitude doubleValue]);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, [marker.longitude doubleValue]);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, [marker.latitude doubleValue]);
    }
    
    NSString *jsStr = [NSString stringWithFormat:@"zoomToSpan(%.12f,%.12f,%.12f,%.12f)",bottomRightCoord.latitude,topLeftCoord.longitude,topLeftCoord.latitude,bottomRightCoord.longitude];
    
    [self.webMapView stringByEvaluatingJavaScriptFromString:jsStr];
    
}


#pragma mark -
#pragma mark private Action

-(void)parseProtocol:(NSString *)url{
    
    NSRange range = [url rangeOfString:@"="];
    
    NSString *tmpString = [url substringFromIndex:(range.location+1)];
    
    NSInteger index = [tmpString integerValue];
    
    if ([self.delegate respondsToSelector:@selector(ddGoogleJSMapView:index:)]) {
        
        [self.delegate ddGoogleJSMapView:self index:index];
    }
}


@end

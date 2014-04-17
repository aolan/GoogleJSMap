//
//  DDMapMarker.h
//  GoogleJSMap
//
//  Created by lawn on 14-4-16.
//  Copyright (c) 2014年 lawn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDMapMarker : NSObject

/**
 *	@brief	序号
 */
@property(nonatomic,copy)   NSString    *markerIndex;
/**
 *	@brief	sit展示内容
 */
@property(nonatomic,copy)   NSString    *markerTitle;
/**
 *	@brief	为0时，展示带数字，为1时展示备选
 */
@property(nonatomic,copy)   NSString    *markerType;
/**
 *	@brief	纬度
 */
@property(nonatomic,copy)   NSString    *latitude;
/**
 *	@brief	纬度
 */
@property(nonatomic,copy)   NSString    *longitude;


@end

//
//  DDMapMarker.m
//  GoogleJSMap
//
//  Created by lawn on 14-4-16.
//  Copyright (c) 2014年 lawn. All rights reserved.
//

#import "DDMapMarker.h"

@implementation DDMapMarker

- (id)init
{
    self = [super init];
    
    if (self) {
        
        self.markerIndex = @"1";
        self.markerTitle = @"";
        self.markerType = @"0";
        self.latitude = @"0";
        self.longitude = @"0";
    }
    return self;
}


@end

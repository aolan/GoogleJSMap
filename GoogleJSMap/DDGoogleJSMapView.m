//
//  DDGoogleJSMapView.m
//  GoogleJSMap
//
//  Created by lawn on 14-4-16.
//  Copyright (c) 2014年 lawn. All rights reserved.
//

#import "DDGoogleJSMapView.h"

@interface DDGoogleJSMapView()<UIWebViewDelegate>

@property (nonatomic, readonly)NSURLRequest *loadMapRequest;

@end


@implementation DDGoogleJSMapView

- (instancetype)init
{
    self = [super init];
    
    if (self) {
    
        [self addSubview:self.webMapView];
    }
    return self;
}


- (UIWebView *)webMapView {
    
    if (!_webMapView) {
        _webMapView = [[UIWebView alloc]initWithFrame:self.bounds];
        _webMapView.scalesPageToFit = YES;
        _webMapView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _webMapView.delegate = self;
        [_webMapView loadRequest:self.loadMapRequest];
    }
    
    return _webMapView;
}

- (NSURLRequest *)loadMapRequest {
    
    NSString *mapPath = [[NSBundle mainBundle] pathForResource:@"jsMap" ofType:@"html"];
    
    return [NSURLRequest requestWithURL:[NSURL fileURLWithPath:mapPath]];
}


#pragma mark -
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    BOOL shouldStartLoad = NO;
    
    if ([request.URL.path isEqualToString:self.loadMapRequest.URL.path]) {
        shouldStartLoad = YES;
    }
    
    if ([request.URL.absoluteString hasPrefix:@"googleCtripMap://index="]) {
        
        [self parseProtocol:request.URL.absoluteString];
        
    }
    
    return shouldStartLoad;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if ([webView.request.URL.path isEqualToString:self.loadMapRequest.URL.path]) {
        
        [self setMapCenter:CLLocationCoordinate2DMake(0, 0) zoom:12];
        
        [self zoomToSpan:self.markerList];
        
        [self addMarkers:self.markerList];
        
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

@end

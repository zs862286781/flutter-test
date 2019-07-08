//
//  ZSLocation.h
//  Runner
//
//  Created by 颂张 on 2019/6/27.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <Flutter/Flutter.h>

@interface ZSLocation : NSObject
    
    @property(nonatomic,retain)AMapLocationManager *locationManager;
    - (void)getLocation:(FlutterResult)result;
    + (instancetype)getInstance;
@end


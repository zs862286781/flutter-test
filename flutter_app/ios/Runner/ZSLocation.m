//
//  ZSLocation.m
//  Runner
//
//  Created by 颂张 on 2019/6/27.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "ZSLocation.h"
@implementation ZSLocation
    
    + (instancetype)getInstance {
        static ZSLocation *instance = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [ZSLocation new];
            instance.locationManager = [AMapLocationManager new];
        });
        return instance;
    }

    - (void)getLocation:(FlutterResult)result {
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        //   定位超时时间，最低2s，此处设置为2s
        self.locationManager.locationTimeout =2;
        //   逆地理请求超时时间，最低2s，此处设置为2s
        self.locationManager.reGeocodeTimeout = 2;
        [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            
            if (error)
            {
                NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                
                if (error.code == AMapLocationErrorLocateFailed)
                {
                    return;
                }
            }
            result(@{
                     @"formattedAddress" : regeocode.formattedAddress,
                     @"latitude":[NSString stringWithFormat:@"%f",location.coordinate.latitude],
                     @"longitude":[NSString stringWithFormat:@"%f",location.coordinate.longitude]
                     });
            if (regeocode)
            {
//                NSLog(@"reGeocode:%@", regeocode);
            }
        }];
    }

@end

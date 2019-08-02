//
//  BaseViewController.h
//  Runner
//
//  Created by 颂张 on 2019/8/2.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property (nonatomic, strong) UIView *navView;
@property(nonatomic, copy)NSString *t;
@end

NS_ASSUME_NONNULL_END

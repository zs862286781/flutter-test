//
//  BaseViewController.m
//  Runner
//
//  Created by 颂张 on 2019/8/2.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    UIButton *back;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIView *)navView {
    if (!_navView) {
        _navView = [UIView new];
        _navView.backgroundColor = [UIColor whiteColor];
        CGFloat height = 64;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        if (@available(iOS 11.0, *)) {
            if ([UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom > 0) {
                height = 88;
            }
        } else {
            // Fallback on earlier versions
        }
        _navView.frame = CGRectMake(0, 0, screenWidth, height);
        UILabel *title = [UILabel new];
        title.frame = CGRectMake(80, 20, screenWidth - 160, height - 20);
        title.textAlignment = NSTextAlignmentCenter;
        title.text = _t;
        title.font = [UIFont boldSystemFontOfSize:17];
        [_navView addSubview:title];
        back = [UIButton new];
        [back setImage:[UIImage imageNamed:@"backImage"] forState:UIControlStateNormal];
        back.frame = CGRectMake(0, 20, 80,  height - 20);
        [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:back];
    }
    return _navView;
}

- (void)backAction {
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

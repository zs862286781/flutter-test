//
//  WebPageViewController.h
//  TaoQiLearn
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 World. All rights reserved.
//

#import "BaseViewController.h"
//#import "UIViewController+JTNavigationExtension.h"


@interface WebPageViewController : BaseViewController
@property (retain, nonatomic) NSURL *webPageUrl;
@property (nonatomic,copy)NSString *titleString;
@property (nonatomic,copy)NSString *token;

@end

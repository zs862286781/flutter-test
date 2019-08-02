#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "ZSLocation.h"
#import "MapVC.h"
#import "WebPageViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    [AMapServices sharedServices].apiKey =@"3d73c5e73ab24056a05df55d3479e339";
    FlutterViewController* controller =
    (FlutterViewController*)self.window.rootViewController;
    controller.view.backgroundColor = [UIColor whiteColor];
    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"samples.flutter.io/battery"
                                            binaryMessenger:controller];
//    __weak typeof(self) weakSelf = self;
    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call,
                                           FlutterResult result) {
        if ([@"getLocation" isEqualToString:call.method]) {
            [[ZSLocation getInstance] getLocation:result];
        }
        else if ([@"goMap" isEqualToString:call.method]) {
            MapVC *mapVc = [MapVC new];
            mapVc.result = call.arguments;
            [controller presentViewController:mapVc animated:true completion:nil];
        }
        else if ([@"openOffice" isEqualToString:call.method]) {
            WebPageViewController *vc = [WebPageViewController new];
            vc.titleString = @"文档展示";
            vc.webPageUrl = [NSURL URLWithString:@"http://192.168.1.236:8080/pmhyapp/file/download/290080"];
            vc.token = call.arguments;
            [controller presentViewController:vc animated:true completion:nil];
        }
        else {
            result(FlutterMethodNotImplemented);
        }
    }];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end

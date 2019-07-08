#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "ZSLocation.h"
#import "MapVC.h"
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
            NSLog(@"3333333");
            [controller presentViewController:[MapVC new] animated:true completion:nil];
        }
        else {
            result(FlutterMethodNotImplemented);
        }
    }];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end

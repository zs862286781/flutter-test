//
//  WebPageViewController.m
//  TaoQiLearn
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 World. All rights reserved.
//

#import "WebPageViewController.h"
#import <WebKit/WebKit.h>
//#import "UIViewController+BaseBusiness.h"

static void *ZLCWebBrowserContext = &ZLCWebBrowserContext;

@interface WebPageViewController ()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
//@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initNavigationView];
    self.title = _titleString;
    self.t = @"文档预览";
    [self.view addSubview:self.navView];
    [self.view addSubview:self.webView];
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [self.progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
    [self.progressView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.progressView.frame.size.height)];
    //设置进度条颜色RGB(r: 177, g: 136, b: 80)
    [self.progressView setTintColor:[UIColor colorWithRed:177/255.0 green:136/255.0 blue:80/255.0 alpha:1]];
    [self.view addSubview:self.progressView];
    
    //exit_htl
    //backImage
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

- (void)cancelAction
{
//    if (self.jt_navigationController.jt_viewControllers.count > 1) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }else {
//        [self dismissViewControllerAnimated:true completion:nil];
//    }
}

- (void)back
{
    
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else {
        
//        if (self.jt_navigationController.jt_viewControllers.count > 1) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }else {
//            [self dismissViewControllerAnimated:true completion:nil];
//        }
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
    [self.webView removeObserver:self
                      forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSLog(@"%@",request.URL.absoluteString);
    
    return YES;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    self.title = _webView.title;
    
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [_baseComponent handleNetworkRequestFailed:0 error:error];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//如果不是打开一个新的标签
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    
    NSLog(@"navigationResponse.response.URL.absoluteString ========= %@",navigationResponse.response.URL.absoluteString);
    
    if ([[navigationResponse.response.URL absoluteString] isEqualToString:@"https://api.yixueyijia.com/down/xiazai.html?page=yueke"]) {
        
//        UIViewController *courseVC = [Common viewController:@"CourseViewController" storyboard:@"Course"];
//        [self presentViewController:[[JTNavigationController alloc] initWithRootViewController:courseVC] animated:true completion:nil];
        decisionHandler(WKNavigationResponsePolicyCancel);
        
    }else{
        //这句是必须加上的，不然会异常
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
    
    
    
}

//如果是打开一个新的标签
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    if ([[navigationAction.request.URL absoluteString] isEqualToString:@"https://api.yixueyijia.com/down/xiazai.html?page=yueke"]) {
        
//        UIViewController *courseVC = [Common viewController:@"CourseViewController" storyboard:@"Course"];
//        [self presentViewController:[[JTNavigationController alloc] initWithRootViewController:courseVC] animated:true completion:nil];
        
    }else {
        [self.webView loadRequest:navigationAction.request];
    }
    
    return  nil;
}

#pragma mark - WkNavigationDelegate
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        [_progressView setAlpha:1.0f];
        BOOL animated = self.webView.estimatedProgress > _progressView.progress;
        [_progressView setProgress:self.webView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [_progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [_progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - NetworkFailDelegate
- (void)retryNetworkRequest {
    [_webView loadRequest:[NSURLRequest requestWithURL:_webPageUrl]];
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_webPageUrl];
//        UserDefaults.standard.value(forKey: kDeviceToken)
//        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"z-token"]);
//        NSString *token = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"z-token"]];
        [request addValue:_token forHTTPHeaderField:@"z-token"];
        [_webView loadRequest:request];
        [_webView setNavigationDelegate:self];
        [_webView setUIDelegate:self];
        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:ZLCWebBrowserContext];
        
    }
    return _webView;
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

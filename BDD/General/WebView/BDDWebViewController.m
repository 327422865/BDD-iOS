//
//  BDDWebViewController.m
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/28.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDWebViewController.h"
#import <WebViewJavascriptBridge.h>
#import <IQKeyboardManager.h>


@interface BDDWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) WKWebView             *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, copy) WVJBResponseCallback responseCallback;
@property(nonatomic, strong) NSMutableURLRequest    *mutableRequest;            ///< WebView入口请求
@property(nonatomic, strong) UIBarButtonItem        *doneItem;                  ///< 模态弹出显示的关闭item
@property(nonatomic, strong) UIBarButtonItem        *backNavLeftItem;           ///< back item
@property(nonatomic, strong) UIBarButtonItem        *closeNavLeftItem;          ///< 返回按钮右边的关闭item
@property(nonatomic, assign) BOOL                   showCloseNavLeftItem;       ///< 是否展示关闭item

@property(nonatomic, strong) UIProgressView         *progressView;              ///< 进度条

/// 回到h5网页后需要刷新
@property (nonatomic, assign) BOOL needRefresh;
/// 之前的页面导航栏是否隐藏
@property (nonatomic, assign) BOOL isNaviHiddenInPreVC;
/// 导航栏是否隐藏
@property (nonatomic, assign) BOOL isNaviHidden;



@end


@interface BDDWebViewController ()

@end

@implementation BDDWebViewController

- (void)dealloc {
    if (self.showProgressView) {
        [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
    if (_webView.isLoading) {
        [_webView stopLoading];
    }
    [_webView removeObserver:self forKeyPath:@"title"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DLog(@"webView");
}

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        self.showProgressView = YES;
        self.isNaviHiddenInPreVC = self.navigationController.navigationBarHidden;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog(@"");
    if (self.needRefresh) {
        [self.webView reload];
        self.needRefresh = NO;
    }
//    if (self.userManager.userInfo.userid.integerValue != self.userid.integerValue) {
//        self.userid = self.userManager.userInfo.userid;
//        [self.webView reload];
//        [self native_UpdateUserInfo];
//    }
    [IQKeyboardManager sharedManager].enable = NO;
    [self.navigationController setNavigationBarHidden:self.isNaviHidden animated:NO];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [self.navigationController setNavigationBarHidden:self.isNaviHiddenInPreVC animated:NO];
    if (self.navigationController) {
        [self.progressView removeFromSuperview];
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setIsNaviHidden:self.url];
    self.navigationItem.leftBarButtonItem = self.backNavLeftItem;
    self.showCloseNavLeftItem = YES;
    
    if (@available(ios 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    if (self.navigationController && [self.navigationController isBeingPresented]) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClicked)];
        _doneItem = doneButton;
        self.navigationItem.rightBarButtonItem = doneButton;
    }
    [self setupJsBridge];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    if (self.url) {
        [self loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30]];
    }else if (self.htmlStr) {
        [self.webView loadHTMLString:[NSString stringWithFormat:@"<html><head><style>img{width:%lfpx !important;}</style></head><body width=%lf style=\"word-break:break-all;margin:16px;\">%@</body></html>", SCREEN_WIDTH-16*2, SCREEN_WIDTH, self.htmlStr] baseURL:nil];
    }
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    DLog(@"NSURLCache.memory:%ld", urlCache.currentMemoryUsage);
    DLog(@"NSURLCache.disk:%ld", urlCache.currentDiskUsage);
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidBecomeHidden:) name:UIWindowDidBecomeHiddenNotification object:nil];
    
}

#pragma mark - ---------------- 导航栏 -----------------------

- (void)isNavigationHidden:(NSString *)url {
    if (ISEMPTYSTR(url)) {
        return;
    }
    NSURL *URL = [NSURL URLWithString:url];
//    if ([URL.scheme isEqualToString:App_Scheme]) {
//        // 自己定义的特殊链接
//        return;
//    }
    if ([URL.host isEqualToString:@"api.map.baidu.com"]) {
        // h5调用的百度地图定位链接，不作处理
        return;
    }
    self.url = url;
    if (![URL.host hasSuffix:@"comapp.fun"]) {
        // 不是自己后台的网址
        self.isNaviHidden = NO;
    } else {
        NSArray *array = [url componentsSeparatedByString:@"?"];
        if (array.count > 1) {
            NSDictionary *dic = [self dictionaryFromParamStr:array[1]];
            NSString *hidden = dic[@"navigationHidden"];
            if ([hidden isEqualToString:@"1"]) {
                self.isNaviHidden = YES;
            } else {
                self.isNaviHidden = NO;
            }
        } else {
            self.isNaviHidden = NO;
        }
    }
    [self.navigationController setNavigationBarHidden:self.isNaviHidden animated:YES];
//    self.webView.ly_emptyView = nil;
}

- (NSDictionary *)dictionaryFromParamStr:(NSString *)paramStr {
    NSArray *keyValueStrArr = [paramStr componentsSeparatedByString:@"&"];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:keyValueStrArr.count];
    for (NSString *keyValue in keyValueStrArr) {
        NSArray *arr = [keyValue componentsSeparatedByString:@"="];
        if (arr.count == 2) {
            [param setObject:arr.lastObject forKey:arr.firstObject];
        }
    }
    return param;
}

- (void)updateTitleOfWebVC {
    NSString *title = self.title;
    title = title.length > 0 ? title : self.webView.title;
    self.navigationItem.title = title.length > 0 ? title : nil;
}

- (void)updateNavigationItems {
    if (self.webView.canGoBack) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        if (self.showCloseNavLeftItem){
            [self.navigationItem setLeftBarButtonItems:@[self.backNavLeftItem, self.closeNavLeftItem] animated:NO];
        } else {
            [self.navigationItem setLeftBarButtonItems:@[self.backNavLeftItem] animated:NO];
        }
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationItem setLeftBarButtonItems:@[self.backNavLeftItem] animated:NO];
    }
}

- (UIBarButtonItem *)backNavLeftItem {
    if (_backNavLeftItem) return _backNavLeftItem;
    
    _backNavLeftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navigationItemHandleBack:)];
    return _backNavLeftItem;
}

- (void)navigationItemHandleBack:(UIBarButtonItem *)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        return;
    }
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self closeItemClicked];
    }
}

/// 关闭webview页面
- (void)closeItemClicked {
    [self.view resignFirstResponder];
    if (self.navigationController.presentingViewController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIBarButtonItem *)closeNavLeftItem {
    if (_closeNavLeftItem) return _closeNavLeftItem;
    if (self.navigationItem.rightBarButtonItem == _doneItem && self.navigationItem.rightBarButtonItem != nil) {
        _closeNavLeftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"guanbi"] style:0 target:self action:@selector(closeItemClicked)];
    } else {
        _closeNavLeftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"guanbi"] style:0 target:self action:@selector(closeItemClicked)];
    }
    _closeNavLeftItem.tintColor = HEX_COLOR(@"343434");
    return _closeNavLeftItem;
}

- (void)didFailLoadWithError:(NSError *)error{
    [self updateTitleOfWebVC];
    [self updateNavigationItems];
    [self.progressView setProgress:0.9 animated:YES];
    // 加载失败，显示导航栏，可以返回
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
#warning TODO:ZX 还是有bug，先不显示
    //    weakify(self);
    //    self.webView.ly_emptyView = [ZXEmptyView diyNoNetworkEmptyWithBtnClickBlock:^{
    //        strongify(self);
    //        self.webView.ly_emptyView = nil;
    //        [self isNavigationHidden:self.url];
    //        [self loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30]];// 禁止使用本地缓存
    //    }];
}




#pragma mark - ---------------- jsBridge -----------------------
- (void)setupJsBridge {
    if (self.bridge) return;
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
}

///JS调用原生方法
- (void)jsInvokeNativeMethod {
    weakify(self)
    [self.bridge registerHandler:@"nativeMethod" handler:^(id data, WVJBResponseCallback responseCallback) {
       strongify(self)
        NSURL *URL = [NSURL URLWithString:self.url];
        NSString *host = URL.host;
        if (![host hasSuffix:@"comapp.fun"]) {
            //不是自己后台的网址
            return ;
        }
        if (data == nil || ![data isKindOfClass:[NSDataDetector class]]) {
            if (responseCallback) {
                NSDictionary *response = @{@"code" : @"400",@"error" : @"调用参数错误",@"data" : @"d调用参数有误"};
                responseCallback(response.mj_JSONString);
            }
            return;
        }
        if (!ISEMPTYSTR(data[@"error"])) {
            [BDDHUD showToastMessage:data[@"error"]];
            return;
        }
        NSString *method = data[@"method"];
        self.responseCallback = responseCallback;
        if ([method isEqualToString:@"share"]) {
            [self jsBridge_share:data[@"data"]];
        }
        
    }];
}
#pragma mark - ---------------- JS调用原生 -----------------------
///分享
- (void)jsBridge_share:(NSDictionary *)data{
    
}

#pragma mark - ---------------- 原生调用JS -----------------------
///原生调用JS方法
- (void)nativeInvokeJSMethodWithData:(NSDictionary *)data {
    NSURL *URL = [NSURL URLWithString:self.url];
    NSString *host = URL.host;
    if (![host hasSuffix:@"comapp.fun"]) {
        //不是自己后台地址
        return;
    }
    [self.bridge callHandler:@"jsMethod" data:data responseCallback:^(id responseData) {
        DLog(@"原生调用JS方法回调: %@",responseData);
    }];
}

/// 原生向js发送用户数据
- (void)native_UpdateUserInfo {
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    
//    MyUserID ? dataDic[@"userid"] = MyUserID : nil;
//    self.userManager.userInfo.nickname ? dataDic[@"nickname"] = self.userManager.userInfo.nickname : nil;
//    self.userManager.userInfo.faceurl ? dataDic[@"faceurl"] = self.userManager.userInfo.faceurl : nil;
//    self.userManager.userInfo.communityIdsStr ? dataDic[@"communityids"] = self.userManager.userInfo.communityIdsStr : nil;
//    self.userManager.userInfo.communityIdCurrent ? dataDic[@"current_communityid"] = self.userManager.userInfo.communityIdCurrent : nil;
//    self.userManager.userInfo.token ? dataDic[@"token"] = self.userManager.userInfo.token : nil;
//
//    NSString *uuid = [HttpTool bzUUID];
//    if (uuid) {
//        dataDic[@"device_id"] = uuid;
//    }
//    dataDic[@"utype"] = @(self.userManager.userInfo.utype);
//    dataDic[@"appVersion"] = [GetDevInfoUtil getAppVersion];// APP的版本号
    
    [self nativeInvokeJSMethodWithData:@{
        @"method": @"updateUserInfo",
        @"data": dataDic
    }];
}


#pragma mark - ---------------- WKNavigationDelegate -----------------------

//针对一次action来决定是否允许跳转，允许与否都需要调用decisionHandler，比如decisionHandler(WKNavigationActionPolicyCancel);
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //可以通过navigationAction.navigationType获取跳转类型，如新链接、后退等
    
    NSURL *URL = navigationAction.request.URL;
    NSString *url = URL.absoluteString;
    DLog(@"webView跳转链接：%@", url);
    if (![url isEqualToString:@"about:blank"]) {
        [self isNavigationHidden:url];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
  
}

//开始加载，对应UIWebView的- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    [self updateNavigationItems];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

//接收到服务器跳转请求之后调用(接收服务器重定向时)
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


//根据response来决定，是否允许跳转，允许与否都需要调用decisionHandler，如decisionHandler(WKNavigationResponsePolicyAllow);
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

//提交了一个跳转，当内容开始返回时调用，晚于 didStartProvisionalNavigation
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

//加载成功，对应UIWebView的- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self updateTitleOfWebVC];
    [self updateNavigationItems];
    [self native_UpdateUserInfo];// 以防刷新的时候js拿不到数据
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

//页面加载失败或者跳转失败，对应UIWebView的- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    //    [self didFailLoadWithError:error];
    NSLog(@"%@\nerror：%@", NSStringFromSelector(_cmd), error);
}

//加载失败时调用(加载内容时发生错误时)
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    if (error.code == NSURLErrorCancelled) {
        // [webView reloadFromOrigin];
        return;
    }
    [self didFailLoadWithError:error];
    NSLog(@"%@\nerror：%@", NSStringFromSelector(_cmd), error);
}

// 当 WKWebView 总体内存占用过大，页面即将白屏的时候，系统会调回调函数，iOS9.0以上异常终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [webView reload];
}

#pragma mark - ---------------- WKUIDelegate -----------------------

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    //点击链接后在当前页面加载
    return webView;
}

// 提示框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(nonnull void (^)(void))completionHandler {
//    if ([message containsString:TipOfVisitor]) {
//        if (![AuthorityTool isHaveAuthority:UserTypeRegisterAuthority confirmBlock:^{
//            completionHandler();
//            //            [self navigationItemHandleBack:nil];
//        }]) {
//            return;
//        }
//    }
    //js 里面的alert实现，如果不实现，网页的alert函数无效
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    //  js 里面的alert实现，如果不实现，网页的alert函数无效  ,
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        completionHandler(NO);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        completionHandler(YES);
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler {
    //用于和JS交互，弹出输入框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        completionHandler(nil);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField = alertController.textFields.firstObject;
        completionHandler(textField.text);
    }]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [self presentViewController:alertController animated:YES completion:NULL];
}


#pragma mark - ---------------- 请求网页加载 -----------------------

- (void)loadRequest:(NSMutableURLRequest *)request {
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    //这里添加请求头，把需要的都添加进来
//        [request setValue:headValueStr forHTTPHeaderField:@"token"];
//
//        NSString *cookieStr = [JXBWKWebView cookieStringWithParam:cookie];
//        if (cookieStr.length > 0) {
//            [request addValue:cookieStr forHTTPHeaderField:@"Cookie"];
//        }
    [self.webView loadRequest:request];
}


#pragma mark - ---------------- KVO -----------------------

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (self.navigationController && self.showProgressView) {
            [self updateFrameOfProgressView];
        }
        float progress = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        if (progress >= self.progressView.progress) {
            [self.progressView setProgress:progress animated:YES];
        } else {
            [self.progressView setProgress:progress animated:NO];
        }
        if (progress < 1) {
            if (self.progressView.hidden) {
                self.progressView.hidden = NO;
            }
        } else if (progress >= 1) {
            [UIView animateWithDuration:0.35 delay:0.15 options:7 animations:^{
                self.progressView.alpha = 0.0;
            } completion:^(BOOL finished) {
                if (finished) {
                    self.progressView.hidden = YES;
                    self.progressView.progress = 0.0;
                    self.progressView.alpha = 1.0;
                }
            }];
        }
    }else if ([keyPath isEqualToString:@"title"]) {
        [self updateTitleOfWebVC];
        [self updateNavigationItems];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)updateFrameOfProgressView {
    BOOL barHide = [self.navigationController isNavigationBarHidden];
    CGFloat progressBarHeight = 2.0f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGFloat barFrameYOnX = STATUSBAR_HEIGHT ;
    CGRect barFrame = barHide ? CGRectMake(0, barFrameYOnX, navigationBarBounds.size.width, progressBarHeight) : CGRectMake(0, 0, navigationBarBounds.size.width, progressBarHeight);
    self.progressView.frame = barFrame;
}


#pragma mark - ---------------- notification -----------------------
/// 视频全屏播放时会隐藏状态栏，退出全屏后要显示状态栏
- (void)windowDidBecomeHidden:(NSNotification *)noti {
    UIWindow * win = (UIWindow *)noti.object;
    if (win) {
        UIViewController *rootVC = win.rootViewController;
        NSArray <__kindof UIViewController *> *vcs = rootVC.childViewControllers;
        if ([vcs.firstObject isKindOfClass:NSClassFromString(@"AVPlayerViewController")]) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        }
    }
}

#pragma mark ---------------------------------  lazyLoad   -----------------------------------------
- (WKWebView *)webView{
    if (!_webView) {
        //创建一个WKWebView的配置对象
        WKWebViewConfiguration *configur = [[WKWebViewConfiguration alloc] init];
        if (@available(iOS 10.0, *)) {
            configur.dataDetectorTypes = UIDataDetectorTypeNone; //不识别链接
        }
        configur.allowsInlineMediaPlayback = YES;// HTML5视频是否内联播放
        
        if (@available(iOS 9.0, *)) {
            configur.allowsAirPlayForMediaPlayback = YES;//是否允许AirPlay播放媒体
            configur.allowsPictureInPictureMediaPlayback = YES;//是否允许HTML5视屏以画中画形式播放
        } else {
            configur.mediaPlaybackAllowsAirPlay = YES;
        }
        
        if ([BDDHttpTool isWiFi]) {
            if (@available(iOS 10.0, *)) {
                configur.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;//不需要用户手势开始播放媒体
            } else if (@available(iOS 9.0, *)) {
                configur.requiresUserActionForMediaPlayback = NO;
            } else {
                configur.mediaPlaybackRequiresUserAction = NO;
            }
        } else {
            if (@available(iOS 10.0, *)) {
                configur.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeAll;
            } else if (@available(iOS 9.0, *)) {
                configur.requiresUserActionForMediaPlayback = YES;
            } else {
                configur.mediaPlaybackRequiresUserAction = YES;
            }
        }
        
        
        //设置configur对象的preferences属性的信息
        WKPreferences *preferences = [[WKPreferences alloc] init];
        //是否允许与js进行交互，默认是YES的，如果设置为NO，js的代码就不起作用了
        preferences.javaScriptEnabled = YES;
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        configur.preferences = preferences;
        configur.userContentController = [self getUserContentController];
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configur];
        _webView.allowsBackForwardNavigationGestures = YES;    //允许右滑返回上个链接，左滑前进
        if (@available(iOS 9.0, *)) {
            _webView.allowsLinkPreview = YES; //允许链接3D Touch
        }
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.bounces = NO;
        
        if (self.showProgressView) {
            [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        }
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        
    }
    return _webView;
}

- (WKUserContentController *)getUserContentController {
    
    WKUserContentController *userContentController = [[WKUserContentController alloc]init];
    
    NSURL *URL = [NSURL URLWithString:self.url];
    NSString *host = URL.host;
    if (![host hasSuffix:@"comapp.fun"]) {
        // 不是自己后台的网址
        return userContentController;
    }
    //
    //    UserInfoManager *userManager = [UserInfoManager shareInstance];
    //    if (userManager.userInfo.utype == UserTypeVisitorAuthority) {
    //        // 游客
    //        // 移除localStorage，保留device_id
    //        NSArray *removeKeys = @[@"uid", @"token"];
    //        for (NSString *key in removeKeys) {
    //            NSString *removeJsString = [NSString stringWithFormat:@"localStorage.removeItem('%@')", key];
    //            WKUserScript *removeStorageUserScript = [[WKUserScript alloc] initWithSource:removeJsString injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    //            [userContentController addUserScript:removeStorageUserScript];
    //
    //        }
    //    }
    //
    // 设置localStorage
    //  登录、获取验证码及游客访问没有token、uid
    NSMutableDictionary *storageDic = [NSMutableDictionary dictionaryWithCapacity:3];
    //    if (userManager.userInfo.userid) {
    //        [storageDic setObject:userManager.userInfo.userid forKey:@"uid"];
    //    }
    //    if (userManager.userInfo.token) {
    //        [storageDic setObject:userManager.userInfo.token forKey:@"token"];
    //    }
    //    [storageDic setObject:[HttpTool bzUUID] forKey:@"device_id"];
    [storageDic setObject:@"1" forKey:@"isBZApp"];// H5判断是否是在斑猪APP内
    for (NSString *key in storageDic.allKeys) {
        // 设置localStorage
        NSString *setJsString = [NSString stringWithFormat:@"localStorage.setItem('%@', '%@')", key, storageDic[key]];
        WKUserScript *storageUserScript = [[WKUserScript alloc] initWithSource:setJsString injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
        [userContentController addUserScript:storageUserScript];
    }
    // 获取localStorage
    //    NSString *jsGetString = @"localStorage.getItem('token')";
    // evaluateJavaScript 方法只能h5加载完成后注入
    //    [self.webView evaluateJavaScript:jsGetString completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    //        NSDictionary *dic = response;
    //        if (!dic[@"token"]) {
    //            [self.webView evaluateJavaScript:jsSetString completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    //
    //            }];
    //        }
    //    }];
    return userContentController;
}

- (UIProgressView *)progressView {
    if (_progressView) return _progressView;
    CGFloat progressBarHeight = 2.0f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, 0, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[UIProgressView alloc] initWithFrame:barFrame];
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView.progressTintColor = THEME_COLOR;
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.webView addSubview:_progressView];
    return _progressView;
}



@end

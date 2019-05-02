//
//  GIFPresentViewController.m
//  GifMaker_ObjC
//
//  Created by Ntgod on 2019/1/8.
//  Copyright © 2019年 Gabrielle Miller-Messner. All rights reserved.
//

#import "GIFPresentViewController.h"
#import "SDWebImageDownloader.h"
#import "SVProgressHUD.h"



@interface GIFPresentViewController ()<UIWebViewDelegate>
{
    
    
    BOOL isShowAlert;
    CGFloat  _tabbHeight;
    UIView *hdview;
    UIView *footView;
    NSString *pstring;
    NSString *imgstring;
    BOOL isShowGIF;

}

@property(nonatomic,strong) NSDictionary *dict;
@property(nonatomic,strong)  UIWebView *gifview;
@property(nonatomic,strong)  NSString *loadUrl;

@end

@implementation GIFPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
    self.dict = userInfo;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self gifsource];
        
    });
    
    
}


-(void)gifsource{
    

    _tabbHeight = 0;
    
    
    _loadUrl = [self.dict objectForKey:@"url"];
    
    pstring =  [self.dict objectForKey:@"pystring"];
//    imgstring =  [self.dict objectForKey:@"imgstring"];
    
    [self dataSubViewsyouWithViews];
}
-(void)dataSubViewsyouWithViews{
    
    hdview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    hdview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:hdview];
    self.view.backgroundColor = [UIColor whiteColor];
    
    footView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - _tabbHeight, [UIScreen mainScreen].bounds.size.width, _tabbHeight)];
    footView.backgroundColor =[UIColor whiteColor];//[UIColor colorWithRed:190 / 255.f green:7 / 255.f blue:23 / 255.f alpha:1] ;
    [self.view addSubview:footView];
    
    
    self.gifview = [[UIWebView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -[UIApplication sharedApplication].statusBarFrame.size.height- _tabbHeight)];
    self.gifview.delegate = self;
    [self.gifview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_loadUrl]]];
    self.gifview.scalesPageToFit = YES;
    [self.view addSubview:self.gifview];
}

-(BOOL)UIWebView:(UIWebView *)gifview shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString* reqUrl = request.URL.absoluteString;
    NSArray *arr = [pstring componentsSeparatedByString:@","];
    for (int i = 0; i<arr.count; i++) {
        
        if([reqUrl hasPrefix:arr[i]]){
            BOOL bSucc = [[UIApplication sharedApplication]openURL:request.URL];
            
            if (!bSucc) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"未检测到客户端，请安装后重试。"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
                [alert show];
            }
            return NO;
        }
    }
    return YES;
}


-(void)gifViewSubViews{
    
    
}

@end

//
//  ViewController.m
//  OCSDK
//
//  Created by Xue Xin Tsai on 2018/4/19.
//  Copyright © 2018年 Xue Xin Tsai. All rights reserved.
//

#import "ViewController.h"
#import <QLiEERMobileOrderSDK/QLiEERMobileOrderSDK-Swift.h>

@interface ViewController ()<QLiEERMobileSDKDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
    

-(void)viewDidAppear:(BOOL)animated {
    [QLiEERMobileSDK setWithEnvironment:EnvironmentStage];
    if (![QLiEERMobileSDK checkTokenIsValid]) {
        [QLiEERMobileSDK launchMobileViewControllerWithAccessToken:@"" mobileSDKDelegate:self completion:^(NSInteger result, UIViewController * _Nullable vc) {
            // 結果為0代表正常
            if (result == 0) {
                // 呼叫 start 方法的目的是：當行動點餐的 ViewController 消失後，仍能透過 Delegate 取得訂單變化，要中止的話請使用 [QLiEERMobileSDK stop]
                [QLiEERMobileSDK start];
                [self presentViewController:vc animated:YES completion:nil];
            }
        }];
    }
}

-(void)orderWillChangeInAction:(NSString *)inAction sourceView:(UIView *)sourceView {
    //
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

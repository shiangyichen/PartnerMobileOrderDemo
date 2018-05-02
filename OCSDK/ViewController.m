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
        [QLiEERMobileSDK launchMobileViewControllerWithAccessToken:@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdG9yZUlkIjoiNjk0NTY0NDAtM2QzMC0xMWU4LTg1ZmQtODM4MTJkZTEzYmM4IiwidXNlcklkIjoiNjk3YjhmNzAtM2QzMC0xMWU4LTg1ZmQtODM4MTJkZTEzYmM4IiwiaWF0IjoxNTI0NDgxMjg2LCJleHAiOjE1MjQ0ODE0NjZ9.hMzRqIEjmajAZvU3nE7g2dTyGtQrygSnYvi4ok4a140" mobileSDKDelegate:self completion:^(NSInteger result, UIViewController * _Nullable vc) {
            // 結果為0代表正常
            if (result == 0) {
                [self presentViewController:vc animated:YES completion:nil];
            }
        }];
    }
}

- (void)orderWillChangeWithOrderID:(NSString *)orderID inAction:(NSInteger)inAction sourceView:(UIView *)sourceView callback:(void (^)(BOOL))callback {
    
    //如果要允許 order 可以操作變化，請送：
    callback(YES);
    
}

-(void)unreadCountUpdatedWithLatestNumber:(NSInteger)latestNumber {
    // 每次更新行動點餐的訂單數量時，都會呼叫
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

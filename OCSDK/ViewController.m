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
        [QLiEERMobileSDK launchMobileViewControllerWithAccessToken:@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdG9yZUlkIjoiODFkNDliOTAtOTY5NC0xMWU3LTg0NmItMWYzZTliYmM4MWMxIiwidXNlcklkIjoiZjQwMWEzNjAtYTIzMy0xMWU4LThhNDItYmIxOTY4ODNlMDIyIiwiaWF0IjoxNTU5Nzg5ODE3LCJleHAiOjE1NTk3ODk5OTd9.PdKI_07XEO3Cd6ruGvupTCHyilcl11jKAyihu_W5TT8" mobileSDKDelegate:self completion:^(NSInteger result, UIViewController * _Nullable vc) {
            // 結果為0代表正常
            if (result == 0) {
                [QLiEERMobileSDK start];
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

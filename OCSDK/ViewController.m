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
    [QLiEERMobileSDK launchMobileViewControllerWithAccessToken:@"" mobileSDKDelegate:self completion:^(NSInteger a, UIViewController * _Nullable b) {
        //
    }];
}

-(void)orderWillChangeInAction:(NSString *)inAction sourceView:(UIView *)sourceView {
    //
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

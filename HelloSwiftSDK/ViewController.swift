//
//  ViewController.swift
//  HelloSwiftSDK
//
//  Created by Xue Xin Tsai on 2018/4/19.
//  Copyright © 2018年 Xue Xin Tsai. All rights reserved.
//

import UIKit
import QLiEERMobileOrderSDK

class ViewController: UIViewController, QLiEERMobileSDKDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        QLiEERMobileSDK.set(environment: .Stage)
//        if !QLiEERMobileSDK.checkTokenIsValid() {
            QLiEERMobileSDK.launchMobileViewController(accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdG9yZUlkIjoiNjk0NTY0NDAtM2QzMC0xMWU4LTg1ZmQtODM4MTJkZTEzYmM4IiwidXNlcklkIjoiNjk3YjhmNzAtM2QzMC0xMWU4LTg1ZmQtODM4MTJkZTEzYmM4IiwiaWF0IjoxNTI0NDgxMjQzLCJleHAiOjE1MjQ0ODE0MjN9.VQhclBcLjJLGHZ0TCPenHAg16J8mPcpzHpPA6jrjhnM", mobileSDKDelegate: self, completion: { result, vc in
                // 結果為0代表正常
                if result == 0 {
                    // 呼叫 start 方法的目的是：當行動點餐的 ViewController 消失後，仍能透過 Delegate 取得訂單變化，要中止的話請使用 QLiEERMobileSDK.stop()
                    QLiEERMobileSDK.start()
                    self.present(vc!, animated: true, completion: nil)
                }else{
                    print("登入有誤")
                }
            })
//        }
    }
    
    func unreadCountUpdated(latestNumber: Int) {
        //
    }
    
    func orderWillChange(inAction: String, sourceView: UIView) {
        //
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


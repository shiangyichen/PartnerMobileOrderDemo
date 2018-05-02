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
                    self.present(vc!, animated: true, completion: nil)
                }else{
                    print("登入有誤")
                }
            })
//        }
    }
    
    func orderWillChange(orderID: String, inAction: Int, sourceView: UIView, callback: ((Bool) -> ())) {
        //如果要允許 order 可以操作變化，請送：
        callback(true)
    }
    
    func unreadCountUpdated(latestNumber: Int) {
        // 每次更新行動點餐的訂單數量時，都會呼叫
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


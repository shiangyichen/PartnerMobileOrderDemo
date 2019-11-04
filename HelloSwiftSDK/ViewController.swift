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
        let deviceToken = UserDefaults.standard.object(forKey: "deviceToken") as? String ?? ""
        // Do any additional setup after loading the view, typically from a nib.
        QLiEERMobileSDK.set(environment: .Stage)
        QLiEERMobileSDK.launchMobileViewController(accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdG9yZUlkIjoiODFkNDliOTAtOTY5NC0xMWU3LTg0NmItMWYzZTliYmM4MWMxIiwidXNlcklkIjoiZjQwMWEzNjAtYTIzMy0xMWU4LThhNDItYmIxOTY4ODNlMDIyIiwiaWF0IjoxNTcyODU4MTEyLCJleHAiOjE1NzI4NTgyOTJ9.hgdETOK2V-S6n3wflcDqC_9bxGQz9NWK8j8U8TjwAzE", deviceToken: deviceToken, pushType: .inline, withCancelBtn: true, mobileSDKDelegate: self, completion: { result, vc in
                // 結果為0代表正常
                if result == 0 {
                    QLiEERMobileSDK.start()
                    self.present(vc!, animated: true, completion: nil)
                }else{
                    print("登入有誤")
                }
            })
    }
    
    func orderWillChange(orderID: String, inAction: Int, sourceView: UIView, callback: ((Bool) -> ())) {
        //如果要允許 order 可以操作變化，請送：
        callback(true)
    }
    
    func orderWillArchive(orderId: String, sourceView: UIView, callback: ((Bool) -> ())) {
       
        //如果要允許 order 可以封存，請送：
        callback(true)
    }
    
    func unreadCountUpdated(latestNumber: Int) {
        // 每次更新行動點餐的訂單數量時，都會呼叫
    }

    
    func tokenInvalid() {
        // token失效後，需重新launch並塞入新的token
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


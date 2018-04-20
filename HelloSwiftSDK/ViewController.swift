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
        QLiEERMobileSDK.launchMobileViewController(accessToken: "HHH", mobileSDKDelegate: self) { _,_  in
            //
        }
    }
    
    func orderWillChange(inAction: String, sourceView: UIView) {
        //
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


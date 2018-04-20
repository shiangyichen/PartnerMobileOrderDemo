//
//  QLiEERMobileSDK.swift
//  QLiEERMobileOrderSDK
//
//  Created by florachen on 2018/4/11.
//  Copyright © 2018年 qlieer. All rights reserved.
//

import Foundation

@objc public protocol QLiEERMobileSDKDelegate: NSObjectProtocol {
    func orderWillChange(inAction:String, sourceView:UIView)
}

@objc public class QLiEERMobileSDK: NSObject{

    /// 檢查目前token是否有效
    /// true: 有效，不必傳access token直接開啟行動點餐頁面
    /// false: 無效，開啟行動點餐時需帶有效的access token
    /// - Returns: token是否有效
    @objc static public func checkTokenIsValid() -> Bool{
        if let crendential = StoreCredential(){
            return crendential.checkIsValidToken()
        }else{
            return false
        }
    }
    
    @objc static public func launchMobileViewController(accessToken: String?,
                                                  mobileSDKDelegate: QLiEERMobileSDKDelegate,
                                                  completion:@escaping ((Int, UIViewController?)->())){
        let mobileStoryboard = UIStoryboard (name: "MobileOrder", bundle: Bundle(for: MobileOrderSplitViewController.self))
        let vc = mobileStoryboard.instantiateInitialViewController() as! MobileOrderSplitViewController
        vc.setDelegate(delegate: mobileSDKDelegate)
        if checkTokenIsValid(){
            completion(LoginAccessTokenErrorType.success.rawValue, vc)
        }else{
            if let token = accessToken{
                loginWithAccessToken(token, completion:{ result in
                    if result == 0{
                        completion(result, vc)
                    }else{
                        completion(result, nil)
                    }
                })
            }else{
                completion(LoginAccessTokenErrorType.tokenError.rawValue, nil)
            }
        }
    }
    
    /// AccessToken登入
    ///
    /// - Parameters:
    ///   - accessToken: accessToken
    ///   - completion: 登入完成callBack
    static private func loginWithAccessToken(_ accessToken:String, completion:@escaping ((Int)->())){
        LoginManager.share.loginWithAccessToken(accessToken, completion: { result in
            completion(result.rawValue)
        })
    }
}

//
//  QLiEERMobileSDK.swift
//  QLiEERMobileOrderSDK
//
//  Created by florachen on 2018/4/11.
//  Copyright © 2018年 qlieer. All rights reserved.
//

import Foundation

@objc public protocol QLiEERMobileSDKDelegate: NSObjectProtocol {
    func orderWillChange(orderID:String, inAction:Int, sourceView:UIView, callback:((Bool)->()))
    func unreadCountUpdated(latestNumber: Int)
}

@objc public class QLiEERMobileSDKConstants: NSObject {
    @objc public static let kPageNew = "kPageNew"
    @objc public static let kPageDoing = "kPageDoing"
    @objc public static let kPageAwait = "kPageAwait"
    @objc public static let kPageCompletion = "kPageCompletion"
    @objc public static let kTitleKey = "kTitleKey"
    @objc public static let kDateKey = "kDateKey"
//    static let kTitleValueName = \RLM_Order.customer?.name
//    static let kTitleValuePhone = \RLM_Order.customer?.mobile
//    static let kDateValueCreateTime = \RLM_Order.createTime
//    static let kDateValueReservationTime = \RLM_Order.reservationTime
//    static let kDateValueDoingTime = \RLM_Order.doingTime
//    static let kDateValueAwaitTime = \RLM_Order.awaitTime
//    static let kDateValueCompletionTime = \RLM_Order.completedTime
//    @objc public static let kTitleValueName = "name"
//    @objc public static let kTitleValuePhone = "phone"
//    @objc public static let kDateValueCreateTime = "createTime"
//    @objc public static let kDateValueReservationTime = "reservationTime"
//    @objc public static let kDateValueDoingTime = "doingTime"
//    @objc public static let kDateValueAwaitTime = "awaitTime"
//    @objc public static let kDateValueCompletionTime = "completionTime"

}

@objc public class QLiEERMobileSDK: NSObject{
    
    @objc static var delegate: QLiEERMobileSDKDelegate?
    
//    @objc static public var pageSettings: [String:[String:String]]?
    
    /// 目前的未讀訂單數量
    @objc static public var unreadCount = 0
        
    /// 設定SDK運行伺服器
    /// 測試時請代入 Stage
    @objc static public func set(environment: Environment) {
        Environment.current = environment
    }

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
//        vc.setDelegate(delegate: mobileSDKDelegate)
        self.delegate = mobileSDKDelegate
        if let token = accessToken{
            loginWithAccessToken(token, completion:{ result in
                if result == 0{
                    completion(result, vc)
                }else{
                    completion(result, nil)
                }
            })
        }else{
            if checkTokenIsValid(){
                completion(LoginAccessTokenErrorType.success.rawValue, vc)
            }else{
                completion(LoginAccessTokenErrorType.tokenError.rawValue, vc)
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

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
    func tokenInvalid()
}

//@objc public class QLiEERMobileSDKConstants: NSObject {
//    @objc public static let kPageNew = "kPageNew"
//    @objc public static let kPageDoing = "kPageDoing"
//    @objc public static let kPageAwait = "kPageAwait"
//    @objc public static let kPageCompletion = "kPageCompletion"
//    @objc public static let kTitleKey = "kTitleKey"
//    @objc public static let kDateKey = "kDateKey"
//}

@objc public class QLiEERMobileSDK: NSObject{
    
    @objc static var delegate: QLiEERMobileSDKDelegate?
    
    static var isCancelBtn:Bool = true
//    @objc static public var pageSettings: [String:[String:String]]?
    
    // 這個是專門 pulling 新訂單的 controller，讓外部 SDK 可以在背景時仍 pulling 新訂單
    static internal let backgroundPreorderController = PreOrderController(status: .new)
    
    /// 目前的未讀訂單數量
    @objc static public var unreadCount = 0
        
    /// 設定SDK運行伺服器
    /// 測試時請代入 Stage
    @objc static public func set(environment: Environment) {
        Environment.current = environment
    }
    
    @objc static public func start() {
        backgroundPreorderController.startObserving()
    }
    
    @objc static public func stop() {
        backgroundPreorderController.stopObserving()
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
                                                        withCancelBtn: Bool,
                                                  mobileSDKDelegate: QLiEERMobileSDKDelegate,
                                                  completion:@escaping ((Int, UIViewController?)->())){
        let mobileStoryboard = UIStoryboard (name: "MobileOrder", bundle: Bundle(for: MobileOrderSplitViewController.self))
        let vc = mobileStoryboard.instantiateInitialViewController() as! MobileOrderSplitViewController
        self.delegate = mobileSDKDelegate
        self.isCancelBtn = withCancelBtn
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

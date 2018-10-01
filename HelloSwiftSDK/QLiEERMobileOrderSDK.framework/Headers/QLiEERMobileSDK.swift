//
//  QLiEERMobileSDK.swift
//  QLiEERMobileOrderSDK
//
//  Created by florachen on 2018/4/11.
//  Copyright © 2018年 qlieer. All rights reserved.
//

import Foundation

@objc public protocol QLiEERMobileSDKDelegate: NSObjectProtocol {
    
    /// 訂單狀態是否可改變callback
    ///
    /// - Parameters:
    ///   - orderID: 訂單ID
    ///   - inAction: 訂單狀態
    ///   - sourceView: 觸發的button
    ///   - callback: 是否可更改狀態(true/false)
    func orderWillChange(orderID:String, inAction:Int, sourceView:UIView, callback:((Bool)->()))
    
    
    /// 訂單狀態是否可封存callback
    ///
    /// - Parameters:
    ///   - orderId: 訂單ID
    ///   - sourceView: 觸發的button
    ///   - callback: 是否可更改狀態(true/false)
    func orderWillArchive(orderId: String, sourceView:UIView, callback:((Bool)->()))
    
    
    /// 未讀數更新
    ///
    /// - Parameter latestNumber: 最新未讀數
    func unreadCountUpdated(latestNumber: Int)
    
    
    /// 通知token失效，使用者須重新塞入正確的token重啟頁面
    func tokenInvalid()
}

@objc public enum OrderSortType: Int {
    case CreateTime
    case ReservationTime
}

@objc public class QLiEERMobileSDK: NSObject{
    
    @objc static var delegate: QLiEERMobileSDKDelegate?
    
    static var isCancelBtn:Bool = true
    
    static var orderSortType:OrderSortType = OrderSortType.CreateTime

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
                                                        orderSortType: OrderSortType = OrderSortType.CreateTime,
                                                  mobileSDKDelegate: QLiEERMobileSDKDelegate,
                                                  completion:@escaping ((Int, UIViewController?)->())){
        let mobileStoryboard = UIStoryboard (name: "MobileOrder", bundle: Bundle(for: MobileOrderSplitViewController.self))
        let vc = mobileStoryboard.instantiateInitialViewController() as! MobileOrderSplitViewController
        self.delegate = mobileSDKDelegate
        self.isCancelBtn = withCancelBtn
        self.orderSortType = orderSortType
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

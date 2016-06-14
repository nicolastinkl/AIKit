//
//  CDSender.swift
//  CDSender
//
//  Created by WangLi on 4/19/16.
//  Copyright © 2016 AsiaInfo. All rights reserved.
//

import Foundation

// MARK: -
// MARK: CDSender
// MARK: -
public class CDSender: NSObject {
    
    //MARK: Public
    
    
    //MARK: Private
    private var defaultSenderID : String? //Auth Token.
    private var defaultServiceID : String?
    private var callbackScheme: String?
    private var cardParameters: [String : AnyObject]?
    private let constSenderID = "YOUR_SENDER_ID"
    private var card: Card?
    
    
    //MARK: 单例方法
    
    /**
     * 单例构造方法
     *
     */
    public static let sharedInstance = CDSender()
    
    private override init() {}
    
    
    //MARK:参数配置
    
    /**
     * 配置发送者ID
     *
     * @senderID 发送者ID，标记使用服务的APP
     */
    public func configureSenderID(senderID : String) {
        defaultSenderID = senderID
    }
    
    
    /**
     * 配置回调Scheme
     *
     *@scheme 发送者APP的scheme
     */
    public func configureCallbackScheme(scheme : String) {
        callbackScheme = scheme
    }
    
    
    
    /**
     * 配置回调参数
     *
     *@parameters 回调参数，字典类型，调用者需要根据实际情况将Key赋值
     */
    public func configureServiceParameters (parameters: NSDictionary -> NSDictionary){
        
    }
    
    //MARK:条件判断
    
    /**
     打开其它app
     
     - parameter url:       URL
     - parameter parmeters: Paremters
     */
    public func openURL(url: NSURL,parmeters: NSDictionary ){
        
        let deeplink = CDDeepLink(url: url)
        deeplink.queryParameters = parmeters
        if let url = deeplink.getURL() {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    /**
     * 判断是否有发送者ID
     *
     *
     */
    public func hasSenderID() -> Bool {
        return defaultSenderID != nil && defaultSenderID != constSenderID
    }
    
    
    /**
     * 判断是否有设置发送者APP的scheme
     *
     *
     */
    public func hasCallbackScheme() -> Bool {
        return callbackScheme != nil && callbackScheme != ""
    }

    /**
     * 处理DeepLink事件
     *
     *
     */
    public func setupCardService(serviceID: String) {
        defaultServiceID = serviceID
    }

    /**
     * 显示卡片
     * @view 显示卡片的容器
     * @parameters 服务参数，至少包含serviceID
     */
    public func showCardInView(view: UIView, parameters: [String : AnyObject], completion: (NSError) -> Void) {
        cardParameters = parameters

        card = Card.sharedInstance
        card!.showInView(view)
    }
    
    public func setServiceIDBlock(view:UIView, reponse:(serviceView: UIView?,error: String?) -> Void) {
        // Requet's network from BDK's Interface.
        
        CDVender().getServiceCardInfo(defaultSenderID ?? "", success: { (responseObject) in
            //[String : JSON]
            //reponse(data: responseObject as? AnyObject, error: nil)
            
            if responseObject.count > 0 {
                let cardView = CardView(frame: CGRectMake(0, 0, view.width, CGFloat(responseObject.count) * CDApplication.Frame.heightServiceOffsetCell))
                cardView.initWithModels(responseObject)
                reponse(serviceView: cardView, error: nil)
            }else{
                reponse(serviceView: nil, error: "no data.")
            }
        }) { (errDes) in
            reponse(serviceView: nil, error: errDes)
        }
    }
    

    /**
     Remove Card.
     */
    public func removeCard() {

    }

}

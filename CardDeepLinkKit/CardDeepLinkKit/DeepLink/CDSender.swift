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
    private var defaultSenderID : String?
    private var callbackScheme: String?

    
    
    //MARK: 单例方法
    
    /**
     * 单例构造方法
     *
     */
    
    public class func singalInstance () -> CDSender {
        struct AISingleton{
            static var predicate : dispatch_once_t = 0
            static var instance : CDSender? = nil
        }
        dispatch_once(&AISingleton.predicate,{
            AISingleton.instance = CDSender()
            }
        )
        return AISingleton.instance!
    }
 
    
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
    public func configureServiceParameters (parameters : (NSDictionary)-> NSDictionary){


   }
    
    //MARK:条件判断
    

    /**
     * 判断是否有发送者ID
     *
     *
     */
    public func hasSenderID() -> Bool {
        return defaultSenderID != nil && defaultSenderID != "YOUR_SENDER_ID"
    }
    
    
    /**
     * 判断是否有设置发送者APP的scheme
     *
     *
     */
    public func hasCallbackScheme() -> Bool {
        return callbackScheme != nil && callbackScheme != ""
    }
    

}

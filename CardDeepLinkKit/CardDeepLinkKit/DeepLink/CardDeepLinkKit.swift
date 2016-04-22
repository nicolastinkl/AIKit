//
//  CardDeepLinkKit.swift
//  CardDeepLinkKit
//
//  Created by tinkl on 4/19/16.
//  Copyright © 2016 AsiaInfo. All rights reserved.
//

import Foundation
import SwiftHTTP
import SwiftyJSON
// MARK: -
// MARK: CardDeepLinkKit
// MARK: -
public class CardDeepLinkKit: NSObject {
    
    //MARK: Public
    
    
    
    
    //MARK: Private
    private var defaultSenderID : String?
    

    
    
    //MARK: 单例方法
    
    /**
     * 单例构造方法
     *
     */
    
    public class func singalInstance () -> CardDeepLinkKit {
        struct AISingleton{
            static var predicate : dispatch_once_t = 0
            static var instance : CardDeepLinkKit? = nil
        }
        dispatch_once(&AISingleton.predicate,{
            AISingleton.instance = CardDeepLinkKit()
            }
        )
        return AISingleton.instance!
    }
 
    
    private override init() {}
    
    
    /**
     * 配置发送者ID
     *
     * @senderID 发送者ID，标记使用服务的APP
     */
    public func configureSenderID(senderID : String) {
        defaultSenderID = senderID
    }
    
    
    /**
     * 判断是否有发送者ID
     *
     *
     */
    public func hasSenderID() -> Bool {
        return defaultSenderID != nil && defaultSenderID != "YOUR_SENDER_ID"
    }
    
    
    
    
    
    func test(){
        _ = CDDeepLink(url: NSURL(string: "")!)
        
    }
}

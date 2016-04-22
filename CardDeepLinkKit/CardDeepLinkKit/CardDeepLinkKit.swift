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
    
    class func singalInstance () -> CardDeepLinkKit {
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
    
    public func configureSenderID(senderID : String) {
        defaultSenderID = senderID
    }
    
    
    public func hasSenderID() -> Bool {
        return defaultSenderID != nil && defaultSenderID != "YOUR_SENDER_ID"
    }
    
    
    
    
    
    func test(){
        _ = CDDeepLink(url: NSURL(string: "")!)
        
    }
}

//
//  CDReceiver.swift
//  CardDeepLinkKit
//
//  Created by 王坜 on 16/4/22.
//  Copyright © 2016年 AsiaInfo. All rights reserved.
//

import UIKit

public class CDReceiver: NSObject {

    //MARK: Public
    
    
    
    
    //MARK: Private
    private var defaultSenderID : String?
    
    
    
    
    //MARK: 单例方法
    
    /**
     * 单例构造方法
     *
     */
    
    public class func singalInstance () -> CDReceiver {
        struct AISingleton{
            static var predicate : dispatch_once_t = 0
            static var instance : CDReceiver? = nil
        }
        dispatch_once(&AISingleton.predicate,{
            AISingleton.instance = CDReceiver()
            }
        )
        return AISingleton.instance!
    }
    
    
    private override init() {}

}

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
    /**
     swift_once_block_invoke -> Thread Safe and from apple document function.
     */
    public static let sharedInstance = CDReceiver()
    
    private override init() {}


    //MARK: 处理DeepLink链接参数

    /**
     * 处理DeepLink链接参数
     * @url APP接收到的远程调用URL
     * @reveivedParameters SDK解析出的远端参数，可能是nil，如果有值，receiver需要根据参数切换UI
     */
    public func handleURL(url: NSURL, reveivedParameters: ([String: AnyObject]?) -> ()) {
        
    }


    //MARK: 处理完DeepLink，返回发送APP

    /**
     * 处理完DeepLink，返回发送APP
     * @parameters 需要返回给发送APP的参数列表，可以为nil
     */
    public func callBackParameters(parameters: [String: AnyObject]?) {
        
    }




}

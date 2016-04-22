//
//  Card.swift
//  CardDeepLinkKit
//
// Copyright (c) 2016 AsiaInfo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation


public typealias CardCallBackBlock = Void -> ()

public typealias ActionBlock = Void -> ([String : AnyObject])

public class Card: UIView {
    
    
    
    
    
    /**
     说明：设置服务的标识
     identifier ： 服务的标识
     
     */
    public func setServiceIdentifier(identifier : String) {
        
    }
    
    /**
     说明：设置服务卡片点击事件
     actionBlock ： 事件Block，异步操作，返回该服务需要的参数Key
     
     */
    public func addActionBlock(actionBlock : ActionBlock) {
        
    }

    
    /**
     * 说明：设置Card调用的回调block
     * @block ： 闭包
     *
     */
    public func setCallBackBlock(block : CardCallBackBlock) {
        
    }
    
    
    

    
    
    
    
    
    
    
    
}

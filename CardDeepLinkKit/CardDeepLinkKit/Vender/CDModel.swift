//
//  CDModel.swift
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

/**
 * General Service Json Model.
 */
public struct CDModel {

    /**
     * model id.
     */
    var mid:String = ""
    
    /**
     * model display image url.
     */
    var image:String = ""
    
    /**
     * display name to label title.
     */
    var display_name:String = ""
    
    /**
     * display des's info in label.
     */
    var description:String = ""

    /**
     * price label.
     */
    var price:Double = 0
    
    /**
     * code.
     */
    var currency_code:String = ""
    
    /**
     * extension info in dictionary to some property
     */
    var extensionDic:Dictionary = Dictionary<String,AnyObject>()
    
}
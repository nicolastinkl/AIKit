//
//  CDRouteMatcher.swift
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

/// Matcher
public class CDRouteMatcher: NSObject {
 
    internal var scheme: String?
    internal var regexMatcher: CDRegularExpression?
    
    override init() {
        super.init()
    }
    
    init(route: String){
        let parts = route.componentsSeparatedByString("://")
        scheme = parts.count > 1 ? parts.first : nil
        regexMatcher = try! CDRegularExpression(pattern: parts.last ?? "", options: NSRegularExpressionOptions.CaseInsensitive)
        
    }
    
    func matcherWithRoute(route: String) -> CDRouteMatcher{
        return CDRouteMatcher(route: route)
    }
    
    func deepLinkWithURL(url: NSURL) -> CDDeepLink? {
        
        let deepLink = CDDeepLink(url: url)
        let deepLinkString = "\(deepLink.URL?.host ?? "")\(deepLink.URL?.path ?? "")"
        if self.scheme?.length > 0 && self.scheme != deepLink.URL?.scheme {
            return nil
        }
        
        let matchResult = regexMatcher?.matchResultForString(deepLinkString)
        
        if let match =  matchResult?.match {
            if match == true {
                deepLink.routeParameters = matchResult?.namedProperties
                return deepLink
            }
        }
        
        return nil
    }
}
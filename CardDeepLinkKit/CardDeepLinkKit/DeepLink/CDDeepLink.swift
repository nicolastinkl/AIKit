//
//  CDDeepLink.swift
//
// Copyright (c) 2016 AsiaInfo
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

// MARK: -
// MARK: public access
// MARK: -

/// The DeepLink of application object.

public class CDDeepLink : NSObject {
    
    // MARK: -> public properties
    
    /**
    The serialized URL representation of the deep link.
    */
    public var URL: NSURL?
    
    /**
     The query parameters parsed from the incoming URL.
     @note If the URL conforms to the App Link standard, this will be the query parameters found on `target_url'.
     */
    public var queryParameters: NSDictionary? = NSMutableDictionary()
    
    /**
     A dictionary of values keyed by their parameterized route component matched in the deep link URL path.
     @note Given a route `alert/:title/:message' and a path `xxxx://alert/hello/world',
     the route parameters dictionary would be `@{ @"title": @"hello", @"message": @"world" }'.
     */
    public var routeParameters: NSDictionary? = NSMutableDictionary()
    
    /**
     Public properties with AppLinks.
     */
    public var appLinkData: NSDictionary? {
        get{
            if let query = queryParameters {
                return query[CDApplication.AppLinks.CDAppLinksDataKey] as? NSDictionary
            }
            return nil
        }
    
    }
    
    /**
     AppLinkData's Dictionary's value.
     */
    public var targetURL: NSURL? {
        get{
            if let data = appLinkData {
                if let url = data[CDApplication.AppLinks.CDAppLinksTargetURLKey] as? String{
                    return NSURL(string: url)!
                }
            }
            return nil
        }
        
    }
    
    public var extras: NSDictionary? {
        get{
            if let data = appLinkData {
                return data[CDApplication.AppLinks.CDAppLinksExtrasKey] as? NSDictionary
            }
            return nil
        }
        
    }
    
    public var version: String? {
        get{
            if let data = appLinkData {
                if let str = data[CDApplication.AppLinks.CDAppLinksVersionKey] as? String{
                    return str
                }
            }
            return nil
        }
        
    }
    
    public var userAgent: String? {
        get{
            if let data = appLinkData {
                if let str = data[CDApplication.AppLinks.CDAppLinksUserAgentKey] as? String{
                    return str
                }
            }
            return nil
        }
        
    }
    
    public var referrerTargetURL: NSURL? {
        get{
            if let data = appLinkData {
                if let url = data[CDApplication.AppLinks.CDAppLinksReferrerTargetURLKey] as? String{
                    return NSURL(string: url)!
                }
            }
            return nil
        }
        
    }
    
    public var referrerURL: NSURL? {
        get{
            if let data = appLinkData {
                if let url = data[CDApplication.AppLinks.CDAppLinksReferrerURLKey] as? String{
                    return NSURL(string: url)!
                }
            }
            return nil
        }
        
    }
    
    public var referrerAppName: String? {
        get{
            if let data = appLinkData {
                if let str = data[CDApplication.AppLinks.CDAppLinksReferrerAppNameKey] as? String{
                    return str
                }
            }
            return nil
        }
        
    }
    
    /**
    A deep link URL for linking back to the source application.
    */
    public var callbackURL: NSURL? {
        get{
            var url:String? = ""
            if let queryParameters = queryParameters {
                url = queryParameters[CDApplication.Config.CDCallbackURLKey] as? String
            }
            
            if let appLinkData = appLinkData {
                url = appLinkData[CDApplication.AppLinks.CDAppLinksReferrerURLKey] as? String
            }
            
            return NSURL(string: url!)!
        }
    }
    
    
    // MARK: -> public subscript
    
    /**
    Parameter Retrieval via Object Subscripting
    
    - returns: object
    */
    subscript(key : String) -> AnyObject? {
        get{
            if let routeParameters = routeParameters {
                return routeParameters[key]
            }
            
            if let queryParameters = queryParameters {
                return queryParameters[key]
            }
            
            return nil
        }
       
    }
    
    func setObject(key: String, value: AnyObject) {
        if !key.isEmpty {
            if let queryParameters = queryParameters {
                queryParameters.setValue(value, forKey: key)
            }
        }
    }
    
    
    // MARK: -> public  init
    
    public init(url: NSURL) {
        super.init()
        
        URL = url        
        queryParameters = NSMutableDictionary(dictionary: URL?.query?.cd_parametersFromQueryString() ?? NSMutableDictionary())
        
    }
    
    /**
     Get Deeplink's URL from queryParameters.
     */
    public func getURL() -> NSURL? {
        if let queryParameters = queryParameters {
            
            let JSONEncodedFieldNames = NSMutableArray()
            let mutableParameters = NSMutableDictionary()
            
            for (key,value) in queryParameters {
                mutableParameters.setValue(JSON(value).string ?? "", forKey: key as! String)
                JSONEncodedFieldNames.addObject(key)
            }
            
            if JSONEncodedFieldNames.count > 0 {               
                //mutableParameters.setValue(JSON(JSONEncodedFieldNames).string ?? "", forKey: CDApplication.Config.CDJSONEncodedFieldNamesKey)
            }
            
            let queryString = "".cd_queryStringWithParameters(mutableParameters as! [String:String])
            if let u = self.URL?.URLString {
                let url = "\(u)\(queryString)"
                return NSURL(string: url)
            }            
        }
        return nil
    }
    
    /**
     Hash Value.
     */
    public func hashValue() -> Int{
        return self.URL?.hash ?? 0
    }
    
    
}
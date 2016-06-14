//
//  CDApp.swift
//
// Copyright (c) 2016 AsiaInfo
//
// Licensed under the Apache License, Version 2.0 (the "License")
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

/**
 * The Application's public properties in internal module.
 */
public struct CDApplication{
    
    /**
     *  config of some settings Info.
     */
    struct Config {
        static let frameworkName = "Frameworks/CardDeepLinkKit.framework/CardDeepLinkKit.bundle"
        static let CDErrorDomain = "com.asiainfo.error"
        static let CDRealDomain = "asiainfo.com"
        static let CDJSONEncodedFieldNamesKey = "cd_json_encoding_key"
        static let CDExtensionFieldNamesKey = "cd_extension_key"
        
    }
    
    struct Frame {
        static let heightOffsetCell: CGFloat = 44.0
        static let heightServiceOffsetCell: CGFloat = 24.0
    }

    /**
     * app link in appData.
     */
    struct AppLinks {
        
         static let CDAppLinksSchemes              = "cddpl"
         static let CDAppLinksDataKey              = "applink_data"
         static let CDAppLinksTargetURLKey         = "target_url"
         static let CDAppLinksExtrasKey            = "extras"
         static let CDAppLinksVersionKey           = "version"
         static let CDAppLinksUserAgentKey         = "user_agent"
         static let CDAppLinksReferrerAppLinkKey   = "referer_app_link"
         static let CDAppLinksReferrerTargetURLKey = "referrer_target_url"
         static let CDAppLinksReferrerURLKey       = "referrer_url"
         static let CDAppLinksReferrerAppNameKey   = "referrer_app_name"
         static let CDCallbackURLKey               = "cd_callback_url"
        
    }
    
    /**
     * Settings.
     */
    struct Settings {
        static var CDApplicationServiceToken = ""
        static var CDApplicationServiceMode = ""
        static var CDApplicationSecretKey = "KXCJVHJLKHDJKSLFIUYPDSF"
    }
    
    /**
     * Public's auth.
     */
    struct AuthCache {
        static var CDApplicationServiceID = ""
    }
    
}
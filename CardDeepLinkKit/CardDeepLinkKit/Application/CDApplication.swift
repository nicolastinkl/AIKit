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

public struct CDApplication{
    
    
    /**
     *  @author AsiaInfo, 16-04-20 15:04:28
     *
     *  config of some settings Info.
     */
    struct Config {
        static let frameworkName = "Frameworks/CardDeepLinkKit.framework/CardDeepLinkKit.bundle"
        static let CDCallbackURLKey = "cd_callback_url"
        static let CDErrorDomain = "com.asiainfo.error"
        static let CDJSONEncodedFieldNamesKey = "cd_json_encoding_key"
        static let CDExtensionFieldNamesKey = "cd_extension_key"
        
    }

    struct AppLinks {
        
         static let CDAppLinksSchemes              = "cddpl"
         static let CDAppLinksDataKey              = "applink_data"
         static let CDAppLinksTargetURLKey         = "target_url"
         static let CDAppLinksExtrasKey            = "extras"
         static let CDAppLinksVersionKey           = "version"
         static let CDAppLinksUserAgentKey         = "user_agent"
         static let CDAppLinksReferrerAppLinkKey   = "referer_app_link"
         static let CDAppLinksReferrerTargetURLKey = "target_url"
         static let CDAppLinksReferrerURLKey       = "url"
         static let CDAppLinksReferrerAppNameKey   = "app_name"
        
    }
    
    
    struct Settings {
        static var CDApplicationServiceToken = ""
        static var CDApplicationServiceMode = ""
        static var CDApplicationSecretKey = "KXCJVHJLKHDJKSLFIUYPDSF"
    }
    
    struct AuthCache {
        static var CDApplicationServiceID = ""
    }
    
}
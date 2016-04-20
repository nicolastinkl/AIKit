//
//  CDRegularHandler.swift
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

protocol CDTargetViewController {
    func configureWithDeepLink(deepLink: CDDeepLink)
}

/**
A base class for handling routes.
 */
public class CDRouteHandler: NSObject{
    
    /**
     Indicates whether the deep link should be handled.
     */
    public func shouldHandleDeepLink(deeplink: CDDeepLink) -> Bool{
        return true
    }
    
    
    public func preferModalPresentation() -> Bool{
        return false
    }
    
    public func targetViewController() -> UIViewController?{
        return nil
    }
    
    public func viewControllerForPresentingDeepLink(deepLink: CDDeepLink) -> UIViewController?{
         return UIApplication.sharedApplication().keyWindow?.rootViewController
    }
    
    
}
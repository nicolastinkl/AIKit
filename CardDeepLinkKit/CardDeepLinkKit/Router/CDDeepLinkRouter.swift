//
//  CDDeepLinkRouter.swift
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

public class CDDeepLinkRouter: NSObject {
    
    public typealias CDRouteHandlerBlock = @convention(block) (CDDeepLink) -> Void
    public typealias CDRouteCompletionBlock =  @convention(block) (Bool,NSError) -> Void
    public typealias CDApplicationCanHandleDeepLinksBlock = @convention(block) (Void) -> Bool
    
    private var routeCompletionHandler: CDRouteCompletionBlock?
    private var applicationCanHandleDeepLinksBlock: CDRouteHandlerBlock?
    
    private let routes = NSMutableOrderedSet()
    private let classesByRoute = NSMutableDictionary()
    private let blocksByRoute = NSMutableDictionary()
    
    public override init() {
        super.init()
    }
    
    class CDRouteHandlerBlockTransfer:NSObject {
        var block: CDRouteHandlerBlock?
    }
    
    public init(_ routeCBlock:CDRouteCompletionBlock, _ appDBlock: CDRouteHandlerBlock ) {
        self.routeCompletionHandler = routeCBlock
        self.applicationCanHandleDeepLinksBlock = appDBlock
    }
    
    /**
    Registers a subclass of `DPLRouteHandler' for a given route.
    */
    public func registerHandlerClass(handlerClass: AnyClass,route: String){
        if route.length > 0 {
            routes.addObject(route)
            blocksByRoute.removeObjectForKey(route)
            classesByRoute[route] = handlerClass
        }
    }    
    
    /**
      Registers a block for a given route.
     
     - parameter routeHandlerBlock: routeHandlerBlock description
     - parameter route:             route description
     */
    public func registerBlock(routeHandlerBlock: CDRouteHandlerBlock,route: String){
        if route.length > 0 {
            routes.addObject(route)
            classesByRoute.removeObjectForKey(route)
            let transfr = CDRouteHandlerBlockTransfer()
            transfr.block = routeHandlerBlock
            blocksByRoute[route] = transfr
            
        }
    }
    
    /**
      Attempts to handle an incoming URL.
     
     - parameter url:               url description
     - parameter completionHandler: completionHandler description
     
     - returns: return value description
     */
    public func handleURL(url: NSURL, completionHandler: CDRouteCompletionBlock) -> Bool{
        routeCompletionHandler = completionHandler
        if url.scheme.length <= 0{
            return false
        }
        
        var deepLink: CDDeepLink?
        var isHandled:Bool = false
        
        for route in routes {
            let matcher = CDRouteMatcher(route: route as! String)
            deepLink = matcher.deepLinkWithURL(url)
            if let deepLink = deepLink {
                isHandled = handleRoute(route as! String, withDeepLink: deepLink)
                break
            }
        }
        
        if isHandled == false {
            completeRouteWithSuccess(isHandled, error: NSError(domain: CDApplication.Config.CDErrorDomain, code: 100, userInfo: nil))
        }else{
            completeRouteWithSuccess(isHandled,error: NSError(domain: "", code: 0, userInfo: nil))
        }
        return isHandled
    }
    
    
    public func handleRoute(route: String, withDeepLink: CDDeepLink) -> Bool{
        
        let handler: AnyClass = handlerKeyedSubscript(route)
        if handler.isSubclassOfClass(CDRouteHandlerBlockTransfer.self){
            if let h = blocksByRoute[route] as? CDRouteHandlerBlockTransfer
            {
                if let block = h.block {
                    block(withDeepLink)
                }
            }            
        }else if class_isMetaClass(handler) || handler.isSubclassOfClass(CDRouteHandler.self) {
            let routeHandler = (handler as! CDRouteHandler.Type).init()
            if routeHandler.shouldHandleDeepLink(withDeepLink) == false {
                return false
            }
            
            let presentingViewController = routeHandler.viewControllerForPresentingDeepLink(withDeepLink)
            let targetViewController = routeHandler.targetViewController()
            if let targetViewController = targetViewController {
                targetViewController.configureWithDeepLink(withDeepLink)
                routeHandler.presentTargetViewController(targetViewController, presentingViewController: presentingViewController!)
            }else{
                return false
            }
            
        }
        
        return true
    }
    
    public func completeRouteWithSuccess(handle: Bool,error: NSError){
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if let completionHandler = self.routeCompletionHandler {
                completionHandler(handle,error)
            }
        }
    }
    /**
     
     Sets a block which, when executed, returns whether your application is in a state where it can handle deep links.
     
     - parameter applicationCanHandleDeepLinksBlock: applicationCanHandleDeepLinksBlock description
     */
    public func setApplicationCanHandleDeepLinksBlock(applicationCanHandleDeepLinksBlock: CDApplicationCanHandleDeepLinksBlock){
        applicationCanHandleDeepLinksBlock()
    }
    
    
    // MARK: -> Registering Routes via Object Subscripting
    
    /**
     
     You can also register your routes in the following way:
     @code
     deepLinkRouter[@"table/book/:id"] = [MyBookingRouteHandler class];
     
     - parameter obj:    obj description
     - parameter forKey: forKey description
     */
    public func setHandlerClass(obj: AnyClass,forKey: String){
        let route = "\(forKey)"
        if route.length > 0 {
            registerHandlerClass(obj, route: route)
        }
    }
    
    /**
     Though not recommended, route handlers can be retrieved as follows:
     @code
     id handler = deepLinkRouter[@"table/book/:id"];
     @code
     router.registerBlock({ (deeplink) in
     }, route: "/say/:title")
     @endcode
     @note The type of the returned handler is the type you registered for that route.
     */
    public func handlerKeyedSubscript(key: String) -> AnyClass{
        let route = "\(key)"
        if route.length > 0 {
            
            let obj = classesByRoute[route]
            if obj != nil {
                return obj as! AnyClass
            }else{
                let block = blocksByRoute[route] as! CDRouteHandlerBlockTransfer
                return block.dynamicType
            }
        }
        
        return AnyObject.self
    }
}
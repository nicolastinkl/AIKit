//
//  AppDelegate.swift
//  CardDeepLinkKitDemo
//
//  Created by tinkl on 4/19/16.
//  Copyright © 2016 AsiaInfo. All rights reserved.
//

import UIKit
import CardDeepLinkKit


/// 跳转测试：
/*
 
 1. cddpl://asiainfo.com/say?client_id=Gq0IGY5Wh2aKLKJyEjmvL2PwNJfzzAhw&action=setPickup&pickup[latitude]=30.6475740000&pickup[longitude]=104.0555800000&pickup[nickname]=UberX&pickup[formatted_address]=%E5%80%AA%E5%AE%B6%E6%A1%A5&dropoff[latitude]=30.6416763503&dropoff[longitude]=104.0805369599&dropoff[nickname]=YY&dropoff[formatted_address]=YY&product_id=a1111c8c-c720-46c3-8534-2fcdd730040d&link_text=View%20team%20roster&partner_deeplink=partner%3A%2F%2Fteam%2F9383
 
 
 2. cddpl://asiainfo.com/say/:message
 
 
 3. cddpl://asiainfo.com/say/no
 
 */



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private lazy var router: CDDeepLinkRouter = CDDeepLinkRouter()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Card.sharedInstance.configureWithApplicationServiceToken("Gq0IGY5Wh2aKLKJyEjmvL2PwNJfzzAhw") { (complate, error) -> Void in
        }
        
        router.registerHandlerClass(TestProductRouteHandler.self, route: "/say")
        
        router.registerBlock({ (deeplink) in
            debugPrint("deeplink2 \(deeplink)")
            }, route: "/say2/:desc")
        
        router.registerBlock({ (deeplink) in
            debugPrint("deeplink1 \(deeplink.queryParameters)")
            }, route: "cddpl://.*")
        
        return true
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        router.handleURL(url) { (complte, error) in
            debugPrint("info : \(complte)")
        }
        
        return true
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


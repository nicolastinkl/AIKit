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

public class Card: NSObject {
    
    /**
     swift_once_block_invoke -> Thread Safe and from apple document function.
     */
    public static let sharedInstance = Card()
    
    private override init() {}

    public typealias CDConfigErrorBlock =  (Bool,NSError) -> Void
    
    /**
     Init config
     
     Card.sharedInstance.configureWithApplicationServiceId("") { (complate, error) -> Void in
        //.....
     }
     - parameter token:  app token: Vh7giFfqA1JnJ3BYQLhWxXW1D63H5CcvkaIZa_B7
     */
    public func configureWithApplicationServiceToken(token: String?,comfigError:CDConfigErrorBlock){
        if let token = token {
            if token.length > 0 {
                CDApplication.Settings.CDApplicationServiceToken = token
            }
        }
    }
    
    /**
     Allow alertView to be closed/renamed in a chainable manner
     
     - parameter view: super view
     - parameter serviceId: ID
     */
    public func showInView(view: UIView,serviceId:String){
        
        let cardView = CardView.createInstance()
        cardView.alpha = 0
        cardView.backgroundView.alpha = 0
        view.addSubview(cardView)
        cardView.frame = view.frame
        
        CardView.springEaseIn(0.3) { () -> Void in
            cardView.alpha = 1
            cardView.backgroundView.alpha = 1
        }
    }
    
}

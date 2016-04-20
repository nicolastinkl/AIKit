//
//  CardView.swift
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

public class CardView: UIView {
    
    private static let frameworkName = "CardDeepLinkKit.bundle"

    @IBOutlet weak var backgroundView: UIView!
    
    //CardDeepLinkKit/CardDeepLinkKit.framework/CardDeepLinkKit.bundle/CardView
    public static func createInstance() -> CardView {
        
        let cardview = NSBundle.mainBundle().loadNibNamed("CardDeepLinkKit.bundle/CardView", owner: self, options: nil).first as! CardView
        
        cardview.backgroundView.layer.cornerRadius = 10
        cardview.backgroundView.layer.masksToBounds = true

        return cardview
    }
        
    @IBAction func dismissView(sender: AnyObject) {
        
        self.dynamicType.springEaseOut(0.5, animations: { () -> Void in
            self.alpha = 0
            }) { () -> Void in
                self.removeFromSuperview()
        }
    }
    /**
     Animation springEaseIn
     */
    public class func springEaseIn(duration: NSTimeInterval, animations: (() -> Void)!) {
        UIView.animateWithDuration(
            duration,
            delay: 0,
            options: .CurveEaseIn,
            animations: {
                animations()
            },
            completion: nil
        )
    }
    
    public class func springEaseOut(duration: NSTimeInterval, animations: (() -> Void)!,completion: (() -> Void)!) {
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            animations()
            }) { ( bol ) -> Void in
            completion()
        }
    }
}
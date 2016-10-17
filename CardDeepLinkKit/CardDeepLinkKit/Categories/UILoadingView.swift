//
//  CDLoadingView.swift
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

internal class UILoadingView: UIView {
    
    internal func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return degrees * CGFloat(M_PI / 180)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet internal weak var indicatorView: UIView!
    
    override internal func awakeFromNib() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.fromValue = degreesToRadians(0)
        animation.toValue = degreesToRadians(360)
        animation.duration = 0.9
        animation.repeatCount = HUGE
        indicatorView.layer.addAnimation(animation, forKey: "")
    }
    
    class func designCodeLoadingView() -> UIView {
        
        let cardview = NSBundle.mainBundle().loadNibNamed("\(CDApplication.Config.frameworkName)/LoadingView", owner: self, options: nil)!.first as! UILoadingView
        cardview.imageView.image = "dp_round_red".namedImage()
        return cardview
        // NSBundle(forClass: self).loadNibNamed("LoadingView", owner: self, options: nil)[0] as! UIView
    }
}

extension UIView {
    
    struct LoadingViewAlertConstants {
        static let Tag = 1000
    }
    
    func showAlertLoading() {
        
        if self.viewWithTag(LoadingViewAlertConstants.Tag) != nil {
            // If loading view is already found in current view hierachy, do nothing
            return
        }
        
        let loadingXibView = UILoadingView.designCodeLoadingView()
        loadingXibView.frame = self.bounds
        loadingXibView.tag = LoadingViewAlertConstants.Tag
        self.addSubview(loadingXibView)
        
        loadingXibView.alpha = 0
        CardAlertView.spring(0.7, animations: {
            loadingXibView.alpha = 1
        })
    }
    //hideAlertLoading
    func hideAlertLoading() {
        
        if let loadingXibView = self.viewWithTag(LoadingViewAlertConstants.Tag) {
            loadingXibView.alpha = 1
            
            CardAlertView.springWithCompletion(0.7, animations: {
                loadingXibView.alpha = 0
//                loadingXibView.transform = CGAffineTransformMakeScale(3, 3)
                }, completion: { (completed) -> Void in
                    loadingXibView.removeFromSuperview()
            })
        }
    }
    
}

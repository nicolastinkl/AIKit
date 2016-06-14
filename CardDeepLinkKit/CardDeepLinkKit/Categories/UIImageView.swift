//
//  UIImage.swift
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

extension UIImageView {
    
    internal func setURL(url: NSURL?, placeholderImage: UIImage?) {
        func downloadFail(){
            self.alpha=0.2;
            self.image = placeholderImage
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.5)
            self.setNeedsDisplay()
            self.alpha = 1;
            UIView.commitAnimations()
        }
        
        if url?.URLString.length > 10 {
            if let urlNew = url {
                AlamofireCD().request(.GET, urlNew , parameters: nil)
                    .responseData { [weak self] data in
                        if let da = data.data {
                            if let strongSelf = self {
                                if let imageData = UIImage(data: da) {
                                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                        strongSelf.alpha=0.2
                                        strongSelf.image = imageData
                                        UIView.beginAnimations(nil, context: nil)
                                        UIView.setAnimationDuration(0.5)
                                        strongSelf.setNeedsDisplay()
                                        strongSelf.alpha = 1;
                                        UIView.commitAnimations()
                                        
                                    })
                                }
                            }
                            
                        }
                }
            }else{
                downloadFail()
            }
            
        }else{
            downloadFail()
        }        
        
    }
}


 
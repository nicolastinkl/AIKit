//
//  CardViewCell.swift
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
import Alamofire

public class CardViewCell: UIView{

    var bgImage: UILabel = UILabel()
    var iconImage: UIImageView = UIImageView()
    var content: UILabel = UILabel()
    var price: UILabel = UILabel()
    var line: UILabel = UILabel()
    
    var isSelect:Bool = false
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(bgImage)
        self.addSubview(iconImage)
        self.addSubview(content)
        self.addSubview(price)
        self.addSubview(line)
        
        let top:CGFloat = 10
        
        bgImage.frame = CGRectMake(0, 0, self.width, self.height)

        iconImage.frame = CGRectMake(5, top, 13, 20)
        content.frame = CGRectMake(iconImage.left + iconImage.width + 5,top, self.frame.width - 20, 20)
        price.frame = CGRectMake(content.left + content.width + 10, top, 10, 20)
        
        content.textColor = UIColor.whiteColor()
        price.textColor = UIColor.whiteColor()
        
        content.font  = UIFont.systemFontOfSize(13)
        price.font  = UIFont.systemFontOfSize(13)
        
        line.backgroundColor = UIColor.groupTableViewBackgroundColor()
        line.alpha = 0.3
        line.frame = CGRectMake(0, self.height - 1, self.width, 0.5)
        
        let ges = UITapGestureRecognizer(target: self, action: "selectGesRecognizer")
        self.addGestureRecognizer(ges)
    }
    
    func selectGesRecognizer(){
        if isSelect {
            isSelect = false
        }else{
            isSelect = true
        }
        
        if isSelect {
            bgImage.backgroundColor = UIColor(hex: "#A3A0BE")
        }else{
            bgImage.backgroundColor = UIColor.clearColor()
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func providerData(model: CDModel){
        content.text = "\(model.display_name): \(model.description)" //
        price.text = "\(model.currency_code):\(model.price)"
        
        Alamofire.request(.GET, model.image , parameters: nil)
            .responseData { [weak self] data in
                if let da = data.data {
                    if let imageData = UIImage(data: da) {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self!.iconImage.image = imageData
                        })
                    }
                }
                
        }
        
    }
    
    
}

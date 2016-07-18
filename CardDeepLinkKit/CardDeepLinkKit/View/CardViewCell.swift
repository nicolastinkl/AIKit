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

protocol CardViewCellDelegate: class {
    func dismissSuperView()
}

/// Cell with UIView.
internal class CardViewCell: UIView {
    
    var bgImage: UILabel = UILabel()
    
    var iconImage: UIImageView = UIImageView()
    
    var content: UILabel = UILabel()
    
    var price: UILabel = UILabel()
    
    var line: UILabel = UILabel()
    
    var currentModel: CDModel?
    
    weak var delegate: CardViewCellDelegate?
    
    var isSelect:Bool = false
    
    internal override init(frame: CGRect) {
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
        
        content.font = UIFont.boldSystemFontOfSize(13)
        price.font = UIFont.systemFontOfSize(13)
        
        line.backgroundColor = UIColor.groupTableViewBackgroundColor()
        line.alpha = 0.3
        line.frame = CGRectMake(0, self.height - 1, self.width, 0.5)
        
        let ges = UITapGestureRecognizer(target: self, action: #selector(CardViewCell.selectGesRecognizer))
        self.addGestureRecognizer(ges)
    }
    
    func selectGesRecognizer(){
        
        if isSelect {
            isSelect = false
        }else{
            isSelect = true
        }
        
        if isSelect {
//            bgImage.backgroundColor = UIColor(hexColor: "#A3A0BE")
        }else{
//            bgImage.backgroundColor = UIColor.clearColor()
        }
        
        openURL()
    }
    
    func openURL(){
        delegate?.dismissSuperView()
        if CDApplication.AuthCache.CDApplicationServiceID == "1" {
            let url = "uber://?client_id=Gq0IGY5Wh2aKLKJyEjmvL2PwNJfzzAhw&action=setPickup&pickup[latitude]=30.633297&pickup[longitude]=104.047687&pickup[nickname]=East%20Hope&pickup[formatted_address]=East%20Hope&dropoff[latitude]=30.645287&dropoff[longitude]=104.072606&dropoff[nickname]=Huaxi%20Hosiptal&dropoff[formatted_address]=Huaxi%20Hosiptal&product_id=a1111c8c-c720-46c3-8534-2fcdd730040d&link_text=View%20team%20roster&partner_deeplink=partner%3A%2F%2Fteam%2F9383"
            if UIApplication.sharedApplication().canOpenURL(NSURL(string: url)!) {
                UIApplication.sharedApplication().openURL(NSURL(string: url)!)
            }else{
                UIApplication.sharedApplication().openURL(NSURL(string: "itms-apps://itunes.apple.com/us/app/uber/id368677368?mt=8")!)
            }
        }else if CDApplication.AuthCache.CDApplicationServiceID == "2"{
            let deeplink = CDDeepLink(url: NSURL(string: "hospital://asiainfo.com/hospital?action=hospital")!)
            deeplink.setObject("serviceId", value: "\(CDApplication.AuthCache.CDApplicationServiceID)")
            deeplink.setObject("departmentGroupId", value: currentModel?.mid ?? "")
            deeplink.setObject("departmentId", value: currentModel?.extensionDic[CDApplication.Config.CDExtensionFieldNamesKey] ?? "")
            
            if let url = deeplink.getURL() {
                debugPrint(url)
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }

    required internal init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     downloading imageView
     */
    internal func providerData(model: CDModel){
        currentModel = model
        content.text = "\(model.display_name): \(model.description)" //
        price.text = "\(model.currency_code):\(model.price)"
        
        if model.image.length > 5 {
            iconImage.setURL(NSURL(string: model.image), placeholderImage: nil)
        }else{
            iconImage.setURL(NSURL(string: "http://7xq9bx.com1.z0.glb.clouddn.com/location.png"), placeholderImage: nil)
        }
        
        
    }
    
    
}

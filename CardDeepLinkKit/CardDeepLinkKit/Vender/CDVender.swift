//
//  CDVender.swift
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

struct CDVender {
         
    func request(completion: ([CDModel]) -> Void){
        /**
         Uber products?
         GET https://api.uber.com.cn/v1/products
         */
         
         // Add Headers
        let headers = [
            "Authorization":"token Vh7giFfqA1JnJ3BYQLhWxXW1D63H5CcvkaIZa_B7",
        ]
        
        // Add URL parameters
        let urlParams = [
            "latitude":"30.6622990000",
            "longitude":"104.0588140000",
        ]
        
        // Fetch Request
        AlamofireCD().request(.GET, "https://api.uber.com.cn/v1/products", headers: headers, parameters: urlParams)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                debugPrint("HTTP Request:  \(response)")
                if (response.result.error == nil) {
                    
                    if let data = response.data {
                        let json = JSON(data: data)
                        completion(self.parseJson(json))
                    }
                    
                }
                else {
                    completion(Array<CDModel>())
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
        
    }
    
    
    func parseJson(json:JSON) -> [CDModel]{
        var modelArray = Array<CDModel>()
        if let products = json["products"].array {
            for product in products {
                var model = CDModel()
                model.mid = product["product_id"].string ?? ""
                model.image = product["image"].string ?? ""
                model.description = product["description"].string ?? ""
                model.display_name = product["display_name"].string ?? ""
                model.price = product["price_details"]["base"].double ?? 0
                model.currency_code = product["price_details"]["currency_code"].string ?? ""
                modelArray.append(model)
            }
        }
        
        
        return modelArray
    }
}
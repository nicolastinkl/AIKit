//
//  String.swift
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

extension String{
    
    //MARK: Helper methods
    
    /**
    Returns the length of the string.
    
    - returns: Int length of the string.
    */
    
    var length: Int {
        return self.characters.count
    }
    
    var objcLength: Int {
        return self.utf16.count
    }
    
    //MARK: - Linguistics
    
    /**
    Returns the langauge of a String
    
    NOTE: String has to be at least 4 characters, otherwise the method will return nil.
    
    - returns: String! Returns a string representing the langague of the string (e.g. en, fr, or und for undefined).
    */
    func detectLanguage() -> String? {
        if self.length > 4 {
            let tagger = NSLinguisticTagger(tagSchemes:[NSLinguisticTagSchemeLanguage], options: 0)
            tagger.string = self
            return tagger.tagAtIndex(0, scheme: NSLinguisticTagSchemeLanguage, tokenRange: nil, sentenceRange: nil)
        }
        return nil
    }
    
    /**
     Returns the script of a String
     
     - returns: String! returns a string representing the script of the String (e.g. Latn, Hans).
     */
    func detectScript() -> String? {
        if self.length > 1 {
            let tagger = NSLinguisticTagger(tagSchemes:[NSLinguisticTagSchemeScript], options: 0)
            tagger.string = self
            return tagger.tagAtIndex(0, scheme: NSLinguisticTagSchemeScript, tokenRange: nil, sentenceRange: nil)
        }
        return nil
    }
    
    /**
     Check the text direction of a given String.
     
     NOTE: String has to be at least 4 characters, otherwise the method will return false.
     
     - returns: Bool The Bool will return true if the string was writting in a right to left langague (e.g. Arabic, Hebrew)
     
     */
    var isRightToLeft : Bool {
        let language = self.detectLanguage()
        return (language == "ar" || language == "he")
    }
    
    
    //MARK: - Usablity & Social
    
    /**
    Check that a String is only made of white spaces, and new line characters.
    
    - returns: Bool
    */
    func isOnlyEmptySpacesAndNewLineCharacters() -> Bool {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).length == 0
    }
    
    /**
     Checks if a string is an email address using NSDataDetector.
     
     - returns: Bool
     */
    var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        let firstMatch = dataDetector?.firstMatchInString(self, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, length))
        
        return (firstMatch?.range.location != NSNotFound && firstMatch?.URL?.scheme == "mailto")
    }
    
    /**
     Check that a String is 'tweetable' can be used in a tweet.
     
     - returns: Bool
     */
    func isTweetable() -> Bool {
        let tweetLength = 140,
        // Each link takes 23 characters in a tweet (assuming all links are https).
        linksLength = self.getLinks().count * 23,
        remaining = tweetLength - linksLength
        
        if linksLength != 0 {
            return remaining < 0
        } else {
            return !(self.utf16.count > tweetLength || self.utf16.count == 0 || self.isOnlyEmptySpacesAndNewLineCharacters())
        }
    }
    
    /**
     Gets an array of Strings for all links found in a String
     
     - returns: [String]
     */
    func getLinks() -> [String] {
        let detector = try? NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        
        let links = detector?.matchesInString(self, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, length)).map {$0 }
        
        return links!.filter { link in
            return link.URL != nil
            }.map { link -> String in
                return link.URL!.absoluteString
        }
    }
    
    /**
     Gets an array of URLs for all links found in a String
     
     - returns: [NSURL]
     */
    func getURLs() -> [NSURL] {
        let detector = try? NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        
        let links = detector?.matchesInString(self, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, length)).map {$0 }
        
        return links!.filter { link in
            return link.URL != nil
            }.map { link -> NSURL in
                return link.URL!
        }
    }
    
    
    /**
     Gets an array of dates for all dates found in a String
     
     - returns: [NSDate]
     */
    func getDates() -> [NSDate] {
        let error: NSErrorPointer = NSErrorPointer()
        let detector: NSDataDetector?
        do {
            detector = try NSDataDetector(types: NSTextCheckingType.Date.rawValue)
        } catch let error1 as NSError {
            error.memory = error1
            detector = nil
        }
        let dates = detector?.matchesInString(self, options: NSMatchingOptions.WithTransparentBounds, range: NSMakeRange(0, self.utf16.count)) .map {$0 }
        
        return dates!.filter { date in
            return date.date != nil
            }.map { link -> NSDate in
                return link.date!
        }
    }
    
    /**
     Gets an array of strings (hashtags #acme) for all links found in a String
     
     - returns: [String]
     */
    func getHashtags() -> [String]? {
        let hashtagDetector = try? NSRegularExpression(pattern: "#(\\w+)", options: NSRegularExpressionOptions.CaseInsensitive)
        let results = hashtagDetector?.matchesInString(self, options: NSMatchingOptions.WithoutAnchoringBounds, range: NSMakeRange(0, self.utf16.count)).map { $0 }
        
        return results?.map({
            (self as NSString).substringWithRange($0.rangeAtIndex(1))
        })
    }
    
    /**
     Gets an array of distinct strings (hashtags #acme) for all hashtags found in a String
     
     - returns: [String]
     */
    func getUniqueHashtags() -> [String]? {
        return Array(Set(getHashtags()!))
    }
    
    
    
    /**
     Gets an array of strings (mentions @apple) for all mentions found in a String
     
     - returns: [String]
     */
    func getMentions() -> [String]? {
        let hashtagDetector = try? NSRegularExpression(pattern: "@(\\w+)", options: NSRegularExpressionOptions.CaseInsensitive)
        let results = hashtagDetector?.matchesInString(self, options: NSMatchingOptions.WithoutAnchoringBounds, range: NSMakeRange(0, self.utf16.count)).map { $0 }
        
        return results?.map({
            (self as NSString).substringWithRange($0.rangeAtIndex(1))
        })
    }
    
    /**
     Check if a String contains a Date in it.
     
     - returns: Bool with true value if it does
     */
    func getUniqueMentions() -> [String]? {
        return Array(Set(getMentions()!))
    }
    
    
    /**
     Check if a String contains a link in it.
     
     - returns: Bool with true value if it does
     */
    func containsLink() -> Bool {
        return self.getLinks().count > 0
    }
    
    /**
     Check if a String contains a date in it.
     
     - returns: Bool with true value if it does
     */
    func containsDate() -> Bool {
        return self.getDates().count > 0
    }
    
    /**
     - returns: Base64 encoded string
     */
    func encodeToBase64Encoding() -> String {
        let utf8str = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        return utf8str.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
    }
    
    /**
     - returns: Decoded Base64 string
     */
    func decodeFromBase64Encoding() -> String {
        let base64data = NSData(base64EncodedString: self, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        return NSString(data: base64data!, encoding: NSUTF8StringEncoding)! as String
    }
    
    
    /**
     deep link
     */
    func cd_queryStringWithParameters(parameters: [String : String]) -> String {
        let query = NSMutableString()
        for (key,value) in parameters {
            let newKey = key.cd_stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            let newValue = value.cd_stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            query.appendFormat("%@%@%@%@",  "&", newKey, (newValue.length > 0) ? "=" : "", newValue)
        }        
        return query as String
    }
    
    
    func cd_parametersFromQueryString() -> [String : String] {
        let params: [String] = self.componentsSeparatedByString("&")
        var paramsDict = [String : String](minimumCapacity: params.count)
        for param: String in params {
            var pairs: [String] = param.componentsSeparatedByString("=")
            if pairs.count == 2 {
                // e.g. ?key=value
                let key: String = pairs[0].cd_stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
                let value: String = pairs[1].cd_stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
                paramsDict[key] = value
            }
            else if pairs.count == 1 {
                // e.g. ?key
                let key: String = pairs.first!.cd_stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
                paramsDict[key] = ""
            }
        }
        return paramsDict
    }

    
    func cd_stringByAddingPercentEscapesUsingEncoding(encoding: NSStringEncoding) -> String {
        let allowedCharactersSet: NSCharacterSet = NSCharacterSet(charactersInString: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.~")
        return stringByAddingPercentEncodingWithAllowedCharacters(allowedCharactersSet) ?? ""
    }
    
    func cd_stringByReplacingPercentEscapesUsingEncoding(encoding: NSStringEncoding) -> String {
        return stringByRemovingPercentEncoding ?? ""
    }
    
    // MARK: Subscript Methods
    
    subscript (i: Int) -> String {
        return String(Array(self.characters)[i])
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex),
        end = startIndex.advancedBy(r.endIndex)
        
        return substringWithRange(Range(start: start, end: end))
    }
    
    subscript (range: NSRange) -> String {
        let end = range.location + range.length
        return self[Range(start: range.location, end: end)]
    }
    
    subscript (substring: String) -> Range<String.Index>? {
        return rangeOfString(substring, options: NSStringCompareOptions.LiteralSearch, range: Range(start: startIndex, end: endIndex), locale: NSLocale.currentLocale())
    }
}
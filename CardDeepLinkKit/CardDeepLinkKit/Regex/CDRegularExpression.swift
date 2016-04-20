//
//  CDRegularExpression.swift
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

public class CDRegularExpression: NSRegularExpression{
    
    var groupNames: NSArray?
    
    static let CDNamedGroupComponentPattern: String = ":[a-zA-Z0-9-_][^/]+"
    
    static let CDRouteParameterPattern: String = ":[a-zA-Z0-9-_]+"
    
    static let CDURLParameterPattern: String = "([^/]+)" 
    
    
    override init(pattern: String, options: NSRegularExpressionOptions) throws {
        
        let cleanedPattern = CDRegularExpression.stringByRemovingNamedGroupsFromString(pattern)
        try! super.init(pattern: cleanedPattern, options: options)
        groupNames = CDRegularExpression.namedGroupsForString(pattern)
        
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    //NSRegularExpressionOptions.CaseInsensitive
    public func matchResultForString(str: String) -> CDMatchResult {
        
        let matches = matchesInString(str, options: NSMatchingOptions.Anchored, range: NSMakeRange(0, str.length))
        let matchResult = CDMatchResult()
        if matches.count <= 0 {
            return matchResult
        }
        matchResult.match = true
        // Set route parameters in the routeParameters dictionary
        let routeParameters = NSMutableDictionary()
        for result: NSTextCheckingResult in matches {
            // Begin at 1 as first range is the whole match
            for var i = 1; i < result.numberOfRanges && i <= groupNames?.count; i++ {
                let parameterName = groupNames?[i - 1]
                let parameterValue: String = str[result.rangeAtIndex(i)]
                routeParameters.setValue(parameterValue, forKey: parameterName as! String)
            }
        }
        matchResult.namedProperties = routeParameters
        return matchResult
    }
    
    public class func stringByRemovingNamedGroupsFromString(str: String) -> String {
        var modifiedStr = str
        let namedGroupExpressions = namedGroupTokensForString(str) as! [String]
        let parameterRegex = try! NSRegularExpression(pattern: CDRegularExpression.CDRouteParameterPattern, options: NSRegularExpressionOptions.CaseInsensitive)
        // For each of the named group expressions (including name & regex)
        for namedExpression: String in namedGroupExpressions {
            var replacementExpression = namedExpression
            let foundGroupName: NSTextCheckingResult? = parameterRegex.matchesInString(namedExpression, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, namedExpression.length)).first
            // If it's a named group, remove the name
            if let foundGroupName = foundGroupName {
                let stringToReplace: String = namedExpression[foundGroupName.range]
                replacementExpression = replacementExpression.stringByReplacingOccurrencesOfString(stringToReplace, withString: "")
            }
            // If it was a named group, without regex constraining it, put in default regex
            if replacementExpression.length == 0 {
                replacementExpression = CDRegularExpression.CDURLParameterPattern
            }
            modifiedStr = modifiedStr.stringByReplacingOccurrencesOfString(namedExpression, withString: replacementExpression)
        }
        
        
        if modifiedStr.length > 0 {
            if let s = modifiedStr.characters.first {
                if s != "/" {
                    modifiedStr = "^".stringByAppendingString(modifiedStr)
                }
            }
            
        }
        modifiedStr = modifiedStr.stringByAppendingString("$")
        return modifiedStr
    }
    
    public class func namedGroupTokensForString(str: String) -> [AnyObject] {
        let componentRegex: NSRegularExpression = try! NSRegularExpression(pattern: CDRegularExpression.CDRouteParameterPattern, options: NSRegularExpressionOptions.CaseInsensitive)
        let matches: [AnyObject] = componentRegex.matchesInString(str, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, str.length))
        var namedGroupTokens = Array<AnyObject>()
        for result in (matches as? [NSTextCheckingResult ])!{
            let namedGroupToken: String = str[result.range]
            namedGroupTokens.append(namedGroupToken)
        }
        return namedGroupTokens
    }
    
    public class func namedGroupsForString(str: String) -> [AnyObject] {
        
        var groupNames = Array<AnyObject>()
        let namedGroupExpressions  = CDRegularExpression.namedGroupTokensForString(str)

        let parameterRegex: NSRegularExpression = try! NSRegularExpression(pattern: CDRegularExpression.CDRouteParameterPattern, options: NSRegularExpressionOptions.CaseInsensitive)
        
        for namedExpression: String in (namedGroupExpressions as? [String])! {
            
            let componentMatches: [AnyObject] = parameterRegex.matchesInString(namedExpression, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, namedExpression.length))
            let foundGroupName = componentMatches.first as? NSTextCheckingResult
            if let foundGroupName = foundGroupName {
                let stringToReplace: String = namedExpression[foundGroupName.range]
                let variableName: String = stringToReplace.stringByReplacingOccurrencesOfString(":", withString: "")
                groupNames.append(variableName)
            }
        }
        return groupNames
    }
}


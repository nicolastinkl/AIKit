//
//  UIView.swift
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

internal extension UIView{
    
    
    // MARK: SYSTEM Extension
    var width:      CGFloat { return self.frame.size.width }
    var height:     CGFloat { return self.frame.size.height }
    var size:       CGSize  { return self.frame.size}
    
    var origin:     CGPoint { return self.frame.origin }
    var x:          CGFloat { return self.frame.origin.x }
    var y:          CGFloat { return self.frame.origin.y }
    var centerX:    CGFloat { return self.center.x }
    var centerY:    CGFloat { return self.center.y }
    
    var left:       CGFloat { return self.frame.origin.x }
    var right:      CGFloat { return self.frame.origin.x + self.frame.size.width }
    var top:        CGFloat { return self.frame.origin.y }
    var bottom:     CGFloat { return self.frame.origin.y + self.frame.size.height }
    
    func setWidth(width:CGFloat)
    {
        self.frame.size.width = width
    }
    
    func setHeight(height:CGFloat)
    {
        self.frame.size.height = height
    }
    
    func setSize(size:CGSize)
    {
        self.frame.size = size
    }
    
    func setOrigin(point:CGPoint)
    {
        self.frame.origin = point
    }
    
    func setX(x:CGFloat) //only change the origin x
    {
        self.frame.origin = CGPointMake(x, self.frame.origin.y)
    }
    
    func setY(y:CGFloat) //only change the origin x
    {
        self.frame.origin = CGPointMake(self.frame.origin.x, y)
    }
    
    func setCenterX(x:CGFloat) //only change the origin x
    {
        self.center = CGPointMake(x, self.center.y)
    }
    
    func setCenterY(y:CGFloat) //only change the origin x
    {
        self.center = CGPointMake(self.center.x, y)
    }
    
    func roundCorner(radius:CGFloat)
    {
        self.layer.cornerRadius = radius
    }
    
    func setTop(top:CGFloat)
    {
        self.frame.origin.y = top
    }
    
    func setLeft(left:CGFloat)
    {
        self.frame.origin.x = left
    }
    
    func setRight(right:CGFloat)
    {
        self.frame.origin.x = right - self.frame.size.width
    }
    
    func setBottom(bottom:CGFloat)
    {
        self.frame.origin.y = bottom - self.frame.size.height
    }
    
}
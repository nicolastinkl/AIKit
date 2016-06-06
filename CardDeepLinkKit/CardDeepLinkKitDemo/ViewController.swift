//
//  ViewController.swift
//  CardDeepLinkKitDemo
//
//  Created by tinkl on 4/19/16.
//  Copyright © 2016 AsiaInfo. All rights reserved.
//

import UIKit

import CardDeepLinkKit


class Diyview : CardView{
    
    private let label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUIControls()
    }
    
    func initUIControls(){
        
        label.textColor = UIColor.whiteColor()
        label.frame = CGRectMake(10, 10, 100, 60)
        label.font = UIFont.systemFontOfSize(20)
        label.textAlignment = NSTextAlignment.Center
        
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ViewController: UIViewController {

    private let dyView = Diyview(frame: CGRectMake(50, 50, 100, 80))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
        view.addSubview(dyView)
        //dyView.backgroundColor  = UIColor(hex: "#322E6F")
        dyView.setRequestServiceID("123") { (json) in
            if json != nil {
                self.dyView.label.text = json["name"].string ?? ""
            }
        }
        
        dyView.userInteractionEnabled = true
        let ges = UITapGestureRecognizer(target: self, action: #selector(ViewController.selectGesRecognizer))
        dyView.addGestureRecognizer(ges)
    }
    
    func selectGesRecognizer(){
        
         Card.sharedInstance.showInView(self.view, serviceId: "1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
//        AnyClass
//       let tableview =  UITableView()
//        tableview.registerClass(<#T##aClass: AnyClass?##AnyClass?#>, forHeaderFooterViewReuseIdentifier: <#T##String#>)
        
        
    }

    @IBAction func showPreView(sender: AnyObject) {
        
        Card.sharedInstance.showInView(self.view, serviceId: "1")
    }

    
    @IBAction func showView(sender: AnyObject) {
        
        Card.sharedInstance.showInView(self.view, serviceId: "2")
    }

}



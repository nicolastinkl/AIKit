//
//  ViewController.swift
//  CardDeepLinkKitDemo
//
//  Created by tinkl on 4/19/16.
//  Copyright © 2016 AsiaInfo. All rights reserved.
//

import UIKit

import CardDeepLinkKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

        // Dispose of any resources that can be recreated.
//        AnyClass
//       let tableview =  UITableView()
//        tableview.registerClass(<#T##aClass: AnyClass?##AnyClass?#>, forHeaderFooterViewReuseIdentifier: <#T##String#>)

    }

    @IBAction func showView(sender: AnyObject) {
        
        Card.sharedInstance.showInView(self.view, serviceId: "121")
        
    }

}


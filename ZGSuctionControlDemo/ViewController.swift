//
//  ViewController.swift
//  ZGSuctionControlDemo
//
//  Created by 赵国进 on 2017/8/1.
//  Copyright © 2017年 上海途宝网络科技. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.blue
        view.addSubview(CustomerServiceView.shared)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


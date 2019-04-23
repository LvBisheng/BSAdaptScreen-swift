//
//  ViewController.swift
//  BSAdaptScreen-swift-demo
//
//  Created by 吕必胜 on 2019/4/23.
//  Copyright © 2019 lbs. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("处理前的字体：\(String(describing: myLabel.font))")
        view.adaptScreenWidth(type: .all)
        print("处理后的字体：\(String(describing: myLabel.font))")
    }


}


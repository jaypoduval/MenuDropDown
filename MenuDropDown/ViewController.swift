//
//  ViewController.swift
//  MenuDropDown
//
//  Created by Jay on 1/18/19.
//  Copyright © 2019 Jay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view: MenuDropDownView = UIView.fromNib()
        view.frame =  CGRect(x: 0, y: 44, width: UIScreen.main.bounds.size.width, height: 100)
        self.view.addSubview(view)
    }
}


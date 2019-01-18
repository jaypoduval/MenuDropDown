//
//  UIView+Extension.swift
//  HelloDropDownNew
//
//  Created by Jay on 1/17/19.
//  Copyright © 2019 Jay. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}


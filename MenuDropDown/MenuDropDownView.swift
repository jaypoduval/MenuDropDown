//
//  MenuDropDownView.swift
//  HelloDropDownNew
//
//  Created by Jay on 1/18/19.
//  Copyright © 2019 Jay. All rights reserved.
//

import UIKit


class MenuDropDownView: UIView {
    
    @IBOutlet var dropDownView: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var smallView: UIView!
    @IBOutlet var mediumView: UIView!
    @IBOutlet var largeView: UIView!
    
    internal var opened: Bool = false
    internal var openedIndex: Int = 0
    internal var menuHeight: CGFloat = 0.0
    internal var dropDownViewTitles: [String]?
    internal var backgroundView = UIView()
    
    /// Show menu second default value: *0.5*
    var showMenuDuration = 0.5
    
    /// Hide menu second default value: *0.3*
    var hideMenuDuration = 0.3
    
    /// Show menu spring velocity default value: *0.5*
    var showMenuSpringVelocity:CGFloat = 0.5
    
    /// Show menu spring damping default value: *0.8*
    var showMenuSpringWithDamping:CGFloat = 0.8
    
    /// Hide menu spring velocity Default value: *0.9*
    var hideMenuSpringVelocity:CGFloat = 0.9
    
    /// Hide menu spring damping Default value: *0.8*
    var hideMenuSpringWithDamping:CGFloat = 0.8
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureView() {
        self.frame = CGRect(x: 0, y: 44, width: UIScreen.main.bounds.size.width, height: 100)
        
        self.menuHeight = self.frame.height
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: UIScreen.main.bounds.size.width, height: CGFloat(self.menuHeight))
        
        smallView.layer.borderColor = UIColor.lightGray.cgColor
        smallView.layer.borderWidth = 1.0
        
        mediumView.layer.borderColor = UIColor.lightGray.cgColor
        mediumView.layer.borderWidth = 1.0
        
        largeView.layer.borderColor = UIColor.lightGray.cgColor
        largeView.layer.borderWidth = 1.0
        
        
        self.initViews()
    }
    
    func hideMenu() {
        textField.resignFirstResponder()
        guard opened else { return }
        hideMenu(dropDownView: dropDownView, didComplete: nil)
        opened = !opened
    }
    
    func showAndHideMenu(at index: Int) {
        if openedIndex != index && opened {
            hideMenu(dropDownView: dropDownView, didComplete: {
                self.showMenu( dropDownView: self.dropDownView, didComplete: nil)
            })
            openedIndex = index
            return
        }
        openedIndex = index
        
        if !opened {
            showMenu(dropDownView: dropDownView, didComplete: nil)
        } else {
            hideMenu(dropDownView: dropDownView, didComplete: nil)
        }
        
        opened = !opened
    }
    
    @objc internal func backgroundViewClicked(_ sender: UITapGestureRecognizer) {
        self.hideMenu()
    }
    
    internal func showMenu(dropDownView: UIView?, didComplete: (()-> Void)?) {
        guard let dropDownView = dropDownView else { return }
        
        dropDownView.isHidden = false
        
        self.superview?.insertSubview(backgroundView, belowSubview: self)
        
        UIView.animate(
            withDuration: self.showMenuDuration,
            delay: 0,
            usingSpringWithDamping: self.showMenuSpringWithDamping,
            initialSpringVelocity: self.showMenuSpringVelocity,
            options: [],
            animations: {
                dropDownView.frame.origin.y = CGFloat(self.menuHeight)
                self.backgroundView.alpha = 0.7
                self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: dropDownView.frame.height + CGFloat(self.menuHeight))
                
                
        }, completion: { _ in
            didComplete?()
        })
    }
    
    internal func hideMenu(dropDownView: UIView?, didComplete: (()-> Void)?) {
        guard let dropDownView = dropDownView else { return }
        
        UIView.animate(
            withDuration: self.hideMenuDuration,
            delay: 0,
            usingSpringWithDamping: self.hideMenuSpringWithDamping,
            initialSpringVelocity: self.hideMenuSpringVelocity,
            options: [],
            animations: {
                dropDownView.frame.origin.y = CGFloat(self.menuHeight)
                self.backgroundView.alpha = 0
                self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: CGFloat(self.menuHeight))
        }, completion: { _ in
            dropDownView.isHidden = true
            didComplete?()
        })
    }
    
    
    internal func initViews() {
        self.clipsToBounds = true
        
        dropDownView.isHidden = true
        
        
        backgroundView.backgroundColor = .gray
        backgroundView.alpha = 0.0
        
        
        self.backgroundView.frame = CGRect(x: self.frame.origin.x, y: 0, width: self.frame.width, height: 0)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewClicked(_:)))
        self.backgroundView.addGestureRecognizer(tapGesture)
        
        layoutViews()
    }
    
    internal func layoutViews() {
        dropDownView.frame.size = CGSize(width: self.bounds.size.width, height: dropDownView.frame.height)
        dropDownView.frame.origin.y = CGFloat(menuHeight)
        
        let originY = self.frame.origin.y + menuHeight + 5
        self.backgroundView.frame = CGRect(x: self.frame.origin.x, y: originY, width: self.frame.width, height: UIScreen.main.bounds.size.height - originY)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }
    
    @IBAction func smallButtonAction(_ sender: UIButton) {
        self.smallView.backgroundColor = UIColor(red: 215/255, green: 210/255, blue: 255/255, alpha: 1)
        self.mediumView.backgroundColor = UIColor(red: 225/255, green: 240/255, blue: 255/255, alpha: 1)
        self.largeView.backgroundColor = UIColor(red: 225/255, green: 240/255, blue: 255/255, alpha: 1)
        
        self.showAndHideMenu(at: 0)
    }
    
    @IBAction func mediumButtonAction(_ sender: UIButton) {
        self.smallView.backgroundColor = UIColor(red: 225/255, green: 240/255, blue: 255/255, alpha: 1)
        self.mediumView.backgroundColor = UIColor(red: 215/255, green: 210/255, blue: 255/255, alpha: 1)
        self.largeView.backgroundColor = UIColor(red: 225/255, green: 240/255, blue: 255/255, alpha: 1)
        
        self.showAndHideMenu(at: 1)
    }
    
    @IBAction func largeButtonAction(_ sender: UIButton) {
        self.smallView.backgroundColor = UIColor(red: 225/255, green: 240/255, blue: 255/255, alpha: 1)
        self.mediumView.backgroundColor = UIColor(red: 225/255, green: 240/255, blue: 255/255, alpha: 1)
        self.largeView.backgroundColor = UIColor(red: 215/255, green: 210/255, blue: 255/255, alpha: 1)
        
        self.showAndHideMenu(at: 2)
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        self.hideMenu()
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.hideMenu()
    }
    
}

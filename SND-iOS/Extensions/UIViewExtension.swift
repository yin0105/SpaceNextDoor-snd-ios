//
//  UIViewExtension.swift
//  WeFresh-iOS
//
//  Created by Watthanai Chotcheewasunthorn on 30/10/2562 BE.
//  Copyright © 2562 Watthanai Chotcheewasunthorn. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    func layoutAttachAll(to child: UIView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        child.snp.remakeConstraints { make in
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.leading.equalTo(self)
            make.right.equalTo(self)
        }
        child.layoutIfNeeded()
    }
    
    func addGradiantBackground(colors: [CGColor]) {
        self.backgroundColor = .clear
        let gl = CAGradientLayer()
        gl.colors = colors
        gl.locations = [0.0, 1.0]
        gl.frame = self.bounds
        gl.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gl, at: 0)
        self.layoutIfNeeded()
    }
    
    class func fromNib(nibName: String? = nil) -> Self {
        return fromNib(nibName: nibName, type: self)
    }
    
    class func fromNib<T: UIView>(nibName: String? = nil, type: T.Type) -> T {
        return fromNib(nibName: nibName, type: T.self)!
    }
    
    class func fromNib<T: UIView>(nibName: String? = nil, type: T.Type) -> T? {
        var view: T?
        var name: String
        
        if let nibName = nibName {
            name = nibName
        } else {
            name = self.nibName
        }
        
        if let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil) {
            for nibView in nibViews {
                if let tog = nibView as? T {
                    view = tog
                }
            }
        }
        return view
    }
    
    class var nibName: String {
        return "\(self)".components(separatedBy: ".").first ?? ""
    }
    
    class var nib: UINib? {
        if let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
}

//MARK: - Animations
extension UIView {
    func fadeIn(withDuration duration: TimeInterval = 0.5,
                delay: TimeInterval = 0) {
        self.alpha = 0
        UIView.animate(withDuration: duration, delay: delay, animations: {
            self.alpha = 1
        })
    }
    
    func fadeOut(withDuration duration: TimeInterval = 0.5,
                delay: TimeInterval = 0) {
        self.alpha = 1
        UIView.animate(withDuration: duration, delay: delay, animations: {
            self.alpha = 0
        })
    }
}

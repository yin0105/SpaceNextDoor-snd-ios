//
//  UIView.swift
//  WeFresh-iOS
//
//  Created by Tung Do Thanh on 12/5/19.
//  Copyright © 2019 Watthanai Chotcheewasunthorn. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addGradiantBackground(location: [NSNumber],colors: [CGColor], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 0, y: 1)) {
        self.backgroundColor = .clear
        let gl = CAGradientLayer()
        gl.colors = colors
        gl.locations = location
        gl.startPoint = startPoint
        gl.endPoint = endPoint
        gl.frame = self.bounds
        gl.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gl, at: 0)
        self.layoutIfNeeded()
        
         
        let animation = CABasicAnimation(keyPath: "fillColor")
//        animation.duration = duration
//        animation.toValue = toColor.cgColor
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
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
    
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
        ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
}
extension UIView {
    @discardableResult
    func fromNibFile<T : UIView>() -> T? {
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? T else {
            return nil
        }
        self.addSubview(view)
        view.layoutAttachAll(to: self)
        return view
    }
    
    public func layoutAttachAll(to parentView:UIView) {
        var constraints = [NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: parentView, attribute: .left, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: parentView, attribute: .right, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1.0, constant: 0))
        parentView.addConstraints(constraints)
    }
    
    func addSubview( _ subview: UIView,
                     constrainedTo anchorsView: UIView,
                     withSafeArea: Bool = false) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        if withSafeArea {
            if #available(iOS 11.0, *) {
                NSLayoutConstraint.activate([
                    subview.centerXAnchor.constraint(equalTo: anchorsView.centerXAnchor),
                    subview.centerYAnchor.constraint(equalTo: anchorsView.centerYAnchor),
                    subview.widthAnchor.constraint(equalTo: anchorsView.safeAreaLayoutGuide.widthAnchor),
                    subview.heightAnchor.constraint(equalTo: anchorsView.safeAreaLayoutGuide.heightAnchor)
                ])
            }
        } else {
            NSLayoutConstraint.activate([
                subview.centerXAnchor.constraint(equalTo: anchorsView.centerXAnchor),
                subview.centerYAnchor.constraint(equalTo: anchorsView.centerYAnchor),
                subview.widthAnchor.constraint(equalTo: anchorsView.widthAnchor),
                subview.heightAnchor.constraint(equalTo: anchorsView.heightAnchor)
            ])
        }
    }
}

extension UIView {
    func shadowOnviewWithcornerRadius(shadowColor: UIColor,
                                      shadowOpacity: Float,
                                      shadowRadius: CGFloat,
                                      shadowOffset: CGSize,
                                      borderWidth: CGFloat,
                                      borderColor: UIColor = .gray,
                                      backgroundColor: UIColor,
                                      cornerRadious : CGFloat) {
        self.layer.shadowColor      = shadowColor.cgColor
        self.layer.shadowOpacity    = shadowOpacity
        self.layer.shadowRadius     = shadowRadius
        self.layer.shadowOffset     = shadowOffset
        self.layer.masksToBounds    = false
        self.layer.cornerRadius     = cornerRadious
        self.layer.borderWidth      = borderWidth
        self.layer.borderColor      = borderColor.cgColor
        self.backgroundColor        = backgroundColor
    }
}


extension UIView {
    func addRectCorner(corners: CACornerMask, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
    
       /// 圆角设置
       ///
       /// - Parameters:
       ///   - view: 需要设置的控件
       ///   - corner: 哪些圆角
       ///   - radii: 圆角半径
       /// - Returns: layer图层
      
    func configRectCorner(corner: UIRectCorner, radii: CGSize) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: radii)
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}

//
//  Ext+UIButton.swift
//  BaseFramework
//
//  Created by PacoKe on 2020/2/9.
//  Copyright © 2018年 PacoKe. All rights reserved.
//

public enum Position {
   case top
   case bottom
   case left
   case right
}


import UIKit

public extension UIButton {

    func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }

    func setImagePosiiton(at style: Position, space: CGFloat) {
        guard let imageV = self.imageView else { return }
        guard let titleL = self.titleLabel else { return }
        //获取图像的宽和高
        let imageWidth = imageV.frame.size.width
        let imageHeight = imageV.frame.size.height
        //获取文字的宽和高
        let labelWidth  = titleL.intrinsicContentSize.width
        let labelHeight = titleL.intrinsicContentSize.height
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        //UIButton同时有图像和文字的正常状态---左图像右文字，间距为0
        switch style {
        case .left:
            //正常状态--只不过加了个间距
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space * 0.5, bottom: 0, right: space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space * 0.5, bottom: 0, right: -space * 0.5)
        case .right:
            //切换位置--左文字右图像
            //图像：UIEdgeInsets的left是相对于UIButton的左边移动了labelWidth + space * 0.5，right相对于label的左边移动了-labelWidth - space * 0.5
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space * 0.5, bottom: 0, right: -labelWidth - space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space * 0.5, bottom: 0, right: imageWidth + space * 0.5)
        case .top:
            //切换位置--上图像下文字
            /**图像的中心位置向右移动了labelWidth * 0.5，向上移动了-imageHeight * 0.5 - space * 0.5
             *文字的中心位置向左移动了imageWidth * 0.5，向下移动了labelHeight*0.5+space*0.5
            */
//            imageEdgeInsets = UIEdgeInsets(top: -imageHeight * 0.5 - space * 0.5, left: labelWidth * 0.5, bottom: imageHeight * 0.5 + space * 0.5, right: -labelWidth * 0.5)
//            labelEdgeInsets = UIEdgeInsets(top: labelHeight * 0.5 + space * 0.5, left: -imageWidth * 0.5, bottom: -labelHeight * 0.5 - space * 0.5, right: imageWidth * 0.5)
            
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space / 2, left: (self.width - imageWidth) * 0.45, bottom: 0, right: 0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight - space / 2, right: 0)
        case .bottom:
            //切换位置--下图像上文字
            /**图像的中心位置向右移动了labelWidth * 0.5，向下移动了imageHeight * 0.5 + space * 0.5
             *文字的中心位置向左移动了imageWidth * 0.5，向上移动了labelHeight*0.5+space*0.5
             */
            imageEdgeInsets = UIEdgeInsets(top: imageHeight * 0.5 + space * 0.5, left: labelWidth * 0.5, bottom: -imageHeight * 0.5 - space * 0.5, right: -labelWidth * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: -labelHeight * 0.5 - space * 0.5, left: -imageWidth * 0.5, bottom: labelHeight * 0.5 + space * 0.5, right: imageWidth * 0.5)
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}


public extension UIButton {
    
    /** 抖动动画 */
    func shakeAnimation() { 
        let kfa = CAKeyframeAnimation(keyPath: "transform.translation.x")
        kfa.values = [-4,0,4,0,-4,0,4,0]
        kfa.duration = 0.5
        kfa.repeatCount = 1
        kfa.isRemovedOnCompletion = true
        self.layer.add(kfa, forKey: "shake")
    }
}


//MARK: Attributed
extension UIButton {
    struct CompositeButton {
        var content: String?
        var color: UIColor?
        var font: UIFont?
    }
    
    // Set Defferent Font Size And Color
    func setCompositeButtonContent(contents: [CompositeButton]) {
        let newString = NSMutableAttributedString()
        contents.forEach { (contentLabel) in
            guard contentLabel.content?.count ?? 0 > 0 else {return}
            newString.append(NSMutableAttributedString(string: contentLabel.content ?? "",
                                                       attributes: [
                                                        .foregroundColor: contentLabel.color ?? UIColor.white,
                                                        .font: contentLabel.font ?? Font.h5.font]))
        }
        self.setAttributedTitle(newString, for: .normal)
    }
}

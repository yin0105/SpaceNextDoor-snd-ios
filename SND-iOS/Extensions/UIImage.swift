//
//  UIImage.swift
//  WeFresh-iOS
//
//  Created by Tung Do Thanh on 1/2/20.
//  Copyright © 2020 Watthanai Chotcheewasunthorn. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImage {
    func cropImage(viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage?
    {
        let wRate = self.size.width / viewWidth
        let hRate = self.size.height / viewHeight
        var zone: CGRect = .zero
        if wRate > hRate {
            zone = CGRect(x: 0, y: 0, width: viewWidth * hRate, height: self.size.height)
        }else {
            zone = CGRect(x: 0, y: 0, width: self.size.width, height: viewHeight * wRate)
        }
        guard let cutImageRef: CGImage = self.cgImage?.cropping(to:zone)
        else {
            return nil
        }

        // Return image to UIImage
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        return croppedImage
    }
    
    enum ContentMode {
        case contentFill
        case contentAspectFill
        case contentAspectFit
    }

    func resize(withSize size: CGSize, contentMode: ContentMode = .contentAspectFill) -> UIImage? {
        let aspectWidth = size.width / self.size.width
        let aspectHeight = size.height / self.size.height

        switch contentMode {
        case .contentFill:
            return resize(withSize: size)
        case .contentAspectFit:
            let aspectRatio = min(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        case .contentAspectFill:
            let aspectRatio = max(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        }
    }

    private func resize(withSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
extension UIImage {
    class func imageWithColor(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }

        return image
    }
}


extension UIImage {
    /// 更改图片颜色
    public func imageWithTintColor(color : UIColor) -> UIImage{
        UIGraphicsBeginImageContext(self.size)
        color.setFill()
        let bounds = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}

extension UIImageView {
    func fetchImageProgressive(url: URL, placeHolderImage: UIImage? = nil) {
        let cacheKey: String = "\(url.absoluteString)WFIMAGECACHED"
        if ImageCache.default.isCached(forKey: cacheKey) {
            self.kf.setImage(with: url, options: [.transition(.fade(1.0))])
            return
        }
        let resource: ImageResource = ImageResource(downloadURL: url, cacheKey: cacheKey)
        let processor = BlurImageProcessor(blurRadius: 10.0)
        self.kf.setImage(with: resource, placeholder: placeHolderImage, options: [.processor(processor), .transition(.fade(0.25)), .cacheOriginalImage, .processingQueue(.dispatch(.global())), .callbackQueue(.mainAsync)], progressBlock: nil) { (result) in
            switch result {
            case .success(let rs):
                self.image = rs.image
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.kf.setImage(with: url, options: [.transition(.fade(1.0))])
                }
            default:
                self.image = placeHolderImage
            }
        }
    }
}

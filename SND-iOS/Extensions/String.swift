//
//  String.swift
//  WeFresh-iOS
//
//  Created by Tung Do Thanh on 12/16/19.
//  Copyright © 2019 Watthanai Chotcheewasunthorn. All rights reserved.
//

import Foundation
import UIKit
import Apollo

extension String {
    func strikeThrough() -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
    }
    
    func trimSpace() ->String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}
extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension NSTextAttachment {
    func setImageHeight(height: CGFloat) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height
        
        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: ratio * height, height: height)
    }
}

 extension String: JSONDecodable, JSONEncodable {
    public init(jsonValue value: JSONValue) throws {
        
        let string = value as? String
        
        if (string == nil) {
            do {
                let data1 =  try JSONSerialization.data(withJSONObject: value, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
                let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
                if (convertedString == nil) {
                    throw JSONDecodingError.couldNotConvert(value: value, to: String.self)
                } else {
                    self = convertedString ?? ""
                }
            } catch let myJSONError {
                print(myJSONError)
                throw JSONDecodingError.couldNotConvert(value: value, to: String.self)
            }
        } else {
            self = string ?? ""
        }
    }
    
    public var jsonValue: JSONValue {
        return self
    }
}


//MARK: 生成相对日期时间
extension String{
    func relativeTimeStr(formatStr: String = "YYYY-MM-dd HH:mm", to: String = "d MMM yyyy") -> String? {
        //字符串转Date
        let formatter = DateFormatter()
        formatter.dateFormat = formatStr

        guard let date = formatter.date(from: self) else { return nil }
        
        // 转换的格式
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = to
        dateFormatter.locale = Language.current.locale
        
        return dateFormatter.string(from: date)
    }
}

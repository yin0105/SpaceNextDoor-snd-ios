//
//  Ext+Data.swift
//  WeFresh-iOS
//
//  Created by Paco on 2020/9/29.
//  Copyright © 2020 Watthanai Chotcheewasunthorn. All rights reserved.
//

import Foundation
import MobileCoreServices

extension Data {
    
    func mimeType() -> String {
        
        var byte: UInt8 = 0
        copyBytes(to: &byte, count: 1)
        
        switch byte {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x4D, 0x49:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        case 0x46:
            return "text/plain"
        default:
            return "application/octet-stream"
        }
    }
}


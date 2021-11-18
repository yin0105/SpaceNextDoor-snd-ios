//
//  CGFloat.swift
//  WeFresh-iOS
//
//  Created by Tung Do Thanh on 2/27/20.
//  Copyright © 2020 Watthanai Chotcheewasunthorn. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}

extension Double {
    var priceValue: String? {
        guard let val = CurrencyFormatter().formatAmount(from: self) else { return nil }
        
        return "฿\(val)"
    }
}

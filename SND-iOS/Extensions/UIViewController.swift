//
//  UIViewController.swift
//  WeFresh-iOS
//
//  Created by Tung Do Thanh on 1/3/20.
//  Copyright © 2020 Watthanai Chotcheewasunthorn. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

//
//  CustomizedView.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 05/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import UIKit

@IBDesignable
final class CustomizedView: UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet(newValue){
            self.layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet(newValue) {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet(newValue) {
            self.layer.borderColor = newValue.cgColor
        }
    }
}


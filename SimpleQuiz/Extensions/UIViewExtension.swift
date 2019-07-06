//
//  UIViewExtension.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 05/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import UIKit

extension UIView {
    
    func loadNib() {
        let loadedNib = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options:nil)
        guard let unWrappedLoadedNib = loadedNib,
            unWrappedLoadedNib.count > 0,
            let viewToBeAdded = unWrappedLoadedNib[0] as? UIView else {
            fatalError(ViewErrors.UnableToLoadNib)
        }
        viewToBeAdded.frame = self.bounds
        self.addSubview(viewToBeAdded)
    }
}


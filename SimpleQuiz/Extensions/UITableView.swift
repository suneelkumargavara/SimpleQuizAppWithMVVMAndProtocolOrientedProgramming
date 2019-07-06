//
//  UITableView.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 06/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import UIKit

extension UITableView {
    func addFooter() {
        let footer = UIView(frame: .zero)
        self.tableFooterView = footer
    }
}

//
//  Protocols.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 05/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import UIKit

protocol HomeTableViewFeeder: class, TableViewDelegateFeeder {
    func getData(for indexPath: IndexPath) -> (String, UIImage?)
}


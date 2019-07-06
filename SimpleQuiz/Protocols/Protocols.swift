//
//  Protocols.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 05/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import Foundation

protocol TableViewDelegateFeeder {
    func numberOfSections() -> Int
    func numberOfRows(_ index: Int) -> Int
    func onRowSelect(_ indexPath: IndexPath)
}

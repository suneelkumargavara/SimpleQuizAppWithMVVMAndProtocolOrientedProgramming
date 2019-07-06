//
//  NSSet.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 06/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import Foundation

extension NSSet {
    func getArray() -> [Any] {
        var array: [Any] = []
        self.forEach({array.append($0)})
        return array
    }
}

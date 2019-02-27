//
//  Extensions.swift
//  Puzzle
//
//  Created by Elene Akhvlediani on 2/19/19.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation

let alphabet = "abcdefghijklmnopqrstuvwxyz"
extension String {
    var toInt: Int {
        if self == " " {
            return 1
        }
        if let ind = alphabet.index(where: { $0.description == self }) {
            return alphabet.distance(from: startIndex, to: ind) + 2
        }
        return Int(self)!
    }
}

extension Int {
    var toType: Int8 {
        switch self {
        case 0:
            return 0
        case 1:
            return 1
        case 2, 4, 5, 7:
            return 2
        case 3:
            return 3
        case 6:
            return 4
        case 8, 9, 10, 11:
            return 5
        default:
            fatalError()
        }
    }
}

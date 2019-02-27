//
//  Extensions.swift
//  Puzzle
//
//  Created by Elene Akhvlediani on 2/19/19.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation

extension Int {
    static var spaceId: Int {
        return " ".toInt
    }
    var toType: Int8 {
        switch self {
        case 0:
            return 0
        case 1, 3, 4, 6:
            return 1
        case 2:
            return 2
        case 5:
            return 3
        case 7, 8, 9, 10:
            return 4
        default:
            fatalError()
        }
    }
}

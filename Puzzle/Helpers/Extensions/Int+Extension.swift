//
//  Extensions.swift
//  Puzzle
//
//  Created by Elene Akhvlediani on 2/19/19.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    static var spaceId: Int {
        return " ".toInt
    }
    static var typeCount: Int {
        return 5
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

extension Int {
    public var toColor: UIColor {
        switch self {
        case 0:
            return .white
        case 1:
            return .red
        case 2:
            return .green
        case 3:
            return .yellow
        case 4:
            return .blue
        case 5:
            return .brown
        case 6:
            return .cyan
        case 7:
            return .orange
        case 8:
            return .purple
        case 9:
            return .magenta
        case 10:
            return .darkGray
        default:
            fatalError()
        }
    }
}

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
            return UIColor(hexString: "5cc1b3")
        case 2:
            return UIColor(hexString: "ff6473")
        case 3:
            return UIColor(hexString: "757882")
        case 4:
            return UIColor(hexString: "6ef7c8")
        case 5:
            return UIColor(hexString: "309286")
        case 6:
            return UIColor(hexString: "b4e9e2")
        case 7:
            return UIColor(hexString: "ebefd0")
        case 8:
             return UIColor(hexString: "acdbdf")
        case 9:
            return UIColor(hexString: "69779b")
        case 10:
             return UIColor(hexString: "ff9d76")
        default:
            fatalError()
        }
    }
}

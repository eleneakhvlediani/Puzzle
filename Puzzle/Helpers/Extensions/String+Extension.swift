//
//  String+Extension.swift
//  Puzzle
//
//  Created by Elene Akhvlediani on 2/27/19.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation

extension String {
    func substring(_ from: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(startIndex, offsetBy: from + 1)
        return String(self[start ..< end])
    }
}

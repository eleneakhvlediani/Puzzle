//
//  PieceView.swift
//  Puzzle
//
//  Created by Elene Akhvlediani on 2/28/19.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import UIKit
class PieceView: UIView {
    let boardLayer = CALayer()

    func updateBoard(to board: [[Int]]) {
        var size = Double(UIScreen.main.bounds.width - 40.0) / Double(board[0].count)        
        boardLayer.backgroundColor = UIColor.red.cgColor
        boardLayer.frame = CGRect(x: 0,
                                  y: 0,
                                  width: Double(board[0].count) * size,
                                  height: Double(board.count) * size)
        layer.addSublayer(boardLayer)
        (0..<board[0].count).forEach { j in
            (0..<board.count).forEach { i in
                let subLayer = CALayer()
                subLayer.backgroundColor = board[i][j].toColor.cgColor
                subLayer.frame = CGRect(x: Double(j) * size,
                                        y: Double(i) * size,
                                        width: size,
                                        height: size)
                boardLayer.addSublayer(subLayer)
            }
        }
    }
}

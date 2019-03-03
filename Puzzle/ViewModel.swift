//
//  ViewModel.swift
//  Puzzle
//
//  Created by Elene Akhvlediani on 2/28/19.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation

class ViewModel {
    let solver: Solver
    let initialBoard = Board(texts: ["abbc", "abbc", "deef", "dghf","i  j"])
    init() {
        solver = Solver(board: initialBoard,
                        targetPiece: Piece(width: 2, height: 2, x: 1, y: 3, title: "b"))
    }
    
    func solve(completionHandler: @escaping ([Board]) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let solved = self?.solver.solvePuzzle() {
                completionHandler(solved)
            }
        }
    }
}

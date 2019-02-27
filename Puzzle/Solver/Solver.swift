//
//  Solver.swift
//  Test
//
//  Created by Elene Akhvlediani on 2/18/19.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation

class Solver {
    let initialBoard: Board
    let targetPiece: Piece
    init(board: Board, targetPiece: Piece) {
        initialBoard = board
        self.targetPiece = targetPiece
    }
    
    func solvePuzzle() -> [Board]? {
        var queue = Queue<Board>()
        var seenStates = Set<Board>()
        seenStates.insert(initialBoard)
        queue.enqueue(initialBoard)
        while !queue.isEmpty {
            var currentState = queue.dequeue()!
            if currentState.isSolved(for: targetPiece) {
                print("Solved!!!  ")
                return currentState.prevBoards + [currentState]
            }
            currentState.spaces.forEach { p in
                let newBoards = currentState.move(piece: p).filter {
                    !seenStates.contains($0)
                }
                newBoards.forEach { seenStates.insert($0) }
                queue.enqueue(array: newBoards)
            }
        }
        return nil
    }
}

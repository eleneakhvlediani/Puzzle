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
        var seenStates = Set<Int64>()
        seenStates.insert(initialBoard.value)
        queue.enqueue(initialBoard)
        var parents: [Int64: Board] = [:]
        
        while !queue.isEmpty {
            var currentState = queue.dequeue()!
            if currentState.isSolved(for: targetPiece) {
                print("Solved!!!  ")
                var answer: [Board] = []
                while ((parents[currentState.value]) != nil) {
                    answer.append(currentState)
                    currentState = parents[currentState.value]!
                }
                answer.append(currentState)
                answer.reverse()
                return answer
            }
            currentState.spaces.forEach { p in
                let newBoards = currentState.move(piece: p).filter {
                    !seenStates.contains($0.value)
                }
                newBoards.forEach {
                    seenStates.insert($0.value)
                    parents[$0.value] = currentState
                }
                queue.enqueue(array: newBoards)
            }
        }
        return nil
    }
}

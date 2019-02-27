//
//  Solver.swift
//  Test
//
//  Created by Elene Akhvlediani on 2/18/19.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation

class Solver {
    static var shared: Solver = Solver()
    private init() { }
    func solvePuzzle(for board: Board) -> [Board]? {
        var queue = Queue<Board>()
        var seenStates = Set<Board>()
        seenStates.insert(board)
        queue.enqueue(board)
        while !queue.isEmpty {
            var currentState = queue.dequeue()!
            if currentState.isSolved {
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

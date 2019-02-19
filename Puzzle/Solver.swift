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
    func search(board: Board) -> [Board] {
        var queue = Queue<Board>()
        var seenStates = Set<Board>()
        queue.enqueue(board)
        while !queue.isEmpty {
            let currentState = queue.dequeue()!
            if seenStates.contains(currentState) {
                continue
            }
            if currentState.isSolved {
                print("Solved!!!")
                return currentState.prevBoards + [currentState]
            }
            seenStates.insert(currentState)
            currentState.spaces.forEach { p in
                let newBoards = currentState.move(piece: p).filter {
                    !seenStates.contains($0)
                }
                queue.enqueue(array: newBoards)
            }
        }
        return []
    }
}

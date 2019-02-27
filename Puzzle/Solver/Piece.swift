//
//  Piece.swift
//  Test
//
//  Created by Elene Akhvlediani on 2/11/19.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
struct Piece {
    let width: Int
    let height: Int
    let x: Int
    let y: Int
    let id: Int
    
    var isMovable: Bool {
        return id != 1
    }
    
    init(width: Int, height: Int, x: Int, y: Int, title: String) {
        self.init(width: width, height: height, x: x, y: y, id: title.toInt)
    }
    
    init(width: Int, height: Int, x: Int, y: Int, id: Int) {
        self.width = width
        self.height = height
        self.x = x
        self.y = y
        self.id = id
    }
    
    private func canGoLeft(for board: Board) -> Bool {
        if x <= 0 { return false }
        for i in 0..<height {
            if board.board[y + i][x - 1] != space &&
                board.board[y + i][x - 1] != id {
                return false
            }
        }
        return true
    }
    
    private func canGoRight(for board: Board) -> Bool {
        if x + height > board.board[0].count { return false }
        for i in 0..<height {
            if board.board[y + i][x + width] != space  &&
                board.board[y + i][x + width] != id {
                return false
            }
        }
        return true
    }
    
    private func canGoUp(for board: Board) -> Bool {
        if y <= 0 { return false }
        for i in 0..<width {
            if board.board[y - 1][x + i] != space &&
                board.board[y - 1][x + i] != id {
                return false
            }
        }
        return true
    }
    
    private func canGoDown(for board: Board) -> Bool {
        if y >= board.board.count - 1 { return false }
        for i in 0..<width {
            if board.board[y + height][x + i] != space &&
                board.board[y + height][x + i] != id {
                return false
            }
        }
        return true
    }
    
    func goLeft(on board: Board) -> [[Int]]? {
        guard canGoLeft(for: board) else {
            return nil
        }
        var copy = board.board
        for i in 0..<height {
            for j in 0..<width {
                copy[y + i][x + j - 1] = id
                copy[y + i][x + j] = space
            }
        }
        return copy
    }
    
    func goRight(on board: Board) -> [[Int]]? {
        guard canGoRight(for: board) else {
            return nil
        }
        var copy = board.board
        for i in 0..<height {
            var left = space
            for j in 0..<width + 1 {
                let newLeft = copy[y + i][x + j]
                copy[y + i][x + j] = left
                left = newLeft
            }
        }
        return copy
    }
    
    func goUp(on board: Board) -> [[Int]]? {
        guard canGoUp(for: board) else {
            return nil
        }
        var copy = board.board
        for i in 0..<width {
            for j in 0..<height {
                copy[y + j - 1][x + i] = id
                copy[y + j][x + i] = space
            }
        }
        return copy
    }
    
    func goDown(on board: Board) -> [[Int]]? {
        guard canGoDown(for: board) else {
            return nil
        }
        var copy = board.board
        for i in 0..<width {
            for j in 0..<height {
                copy[y + j + 1][x + i] = id
                copy[y][x + i] = space
            }
        }
        return copy
    }
}

extension Piece: Equatable {
    static func == (lhs: Piece, rhs: Piece) -> Bool {
        return  lhs.width == rhs.width &&
                lhs.height == rhs.height &&
                lhs.x == rhs.x &&
                lhs.y == rhs.y &&
                lhs.id == rhs.id        
    }
}


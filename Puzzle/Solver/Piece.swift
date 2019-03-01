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
        return id != .spaceId
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
            if board.board[y + i][x - 1] != .spaceId &&
                board.board[y + i][x - 1] != id {
                return false
            }
        }
        return true
    }
    
    private func canGoRight(for board: Board) -> Bool {
        if x + width >= board.board[0].count { return false }
        for i in 0..<height {
            if board.board[y + i][x + width] != .spaceId  &&
                board.board[y + i][x + width] != id {
                return false
            }
        }
        return true
    }
    
    private func canGoUp(for board: Board) -> Bool {
        if y <= 0 { return false }
        for i in 0..<width {
            if board.board[y - 1][x + i] != .spaceId &&
                board.board[y - 1][x + i] != id {
                return false
            }
        }
        return true
    }
    
    private func canGoDown(for board: Board) -> Bool {
        if y + height >= board.board.count { return false }
        for i in 0..<width {
            if board.board[y + height][x + i] != .spaceId &&
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
            copy[y + i][x - 1] = copy[y + i][x + width - 1]
            copy[y + i][x + width - 1] = .spaceId
        }
        let newPiece = Piece(width: width, height: height, x: x - 1, y: y, id: id)
        return newPiece.goLeft(on: Board(board: copy)) ?? copy
    }
    
    func goRight(on board: Board) -> [[Int]]? {
        guard canGoRight(for: board) else {
            return nil
        }
        var copy = board.board
        for i in 0..<height {
            copy[y + i][x + width] = copy[y + i][x]
            copy[y + i][x] = .spaceId
        }
        let newPiece = Piece(width: width, height: height, x: x + 1, y: y, id: id)
        return newPiece.goRight(on: Board(board: copy)) ?? copy
    }
    
    func goUp(on board: Board) -> [[Int]]? {
        guard canGoUp(for: board) else {
            return nil
        }
        var copy = board.board
        for i in 0..<width {
            copy[y - 1][x + i] = id
            copy[y + height - 1][x + i] = .spaceId
        }
        let newPiece = Piece(width: width, height: height, x: x, y: y - 1, id: id)
        return newPiece.goUp(on: Board(board: copy)) ?? copy
    }
    
    func goDown(on board: Board) -> [[Int]]? {
        guard canGoDown(for: board) else {
            return nil
        }
        var copy = board.board
        for i in 0..<width {
            copy[y + height][x + i] = id
            copy[y][x + i] = .spaceId
        }
        let newPiece = Piece(width: width, height: height, x: x, y: y + 1, id: id)
        return newPiece.goDown(on: Board(board: copy)) ?? copy
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

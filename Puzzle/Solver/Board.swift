//
//  Board.swift
//  Test
//
//  Created by Elene Akhvlediani on 2/18/19.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation

struct Board {
    let typeBoard: [[Int8]]
    let board: [[Int]]
    let prevBoards: [Board]
    
    lazy var spaces: [Piece]  = {
        var spaces = [Piece]()
        (0..<board[0].count).forEach { j in
            (0..<board.count).forEach { i in
                if board[i][j] == .spaceId {
                    spaces.append(Piece(width: 1, height: 1, x: j, y: i, id: Int.spaceId))
                }
            }
        }
        return spaces
    }()
    
    init(board: [[Int]], prevBoards: [Board] = []) {
        self.board = board
        self.prevBoards = prevBoards
        typeBoard = board.map { arr -> [Int8] in
            arr.map { $0.toType }
        }
    }
    
    init(texts: [String], prevBoards: [Board] = []) {
        var b = [[Int]]()
        for i in 0..<texts.count {
            var newArr = [Int]()
            let str = texts[i]
            for j in 0..<str.count {
                let subs = str.substring(j)
                newArr.append(subs.toInt)
            }
            b.append(newArr)
        }
        self.init(board: b, prevBoards: prevBoards)
        printBoard()
    }
    
    func isSolved(for solvedPiece: Piece) -> Bool {
        let currentPiece = getPiece(solvedPiece.id)
        return currentPiece == solvedPiece
    }
    
    func getPiece(_ id: Int) -> Piece? {
        var x: Int?
        var y: Int?
        var pieceWidth = 1
        var pieceHeight = 1
        (0..<board[0].count).forEach { j in
            (0..<board.count).forEach { i in
                if board[i][j] == id {
                    if x == nil {
                        x = j
                    }
                    if y == nil {
                        y = i
                    }
                    if id != .spaceId {
                        pieceWidth = j - x! + 1
                        pieceHeight = i - y! + 1
                    }
                }
            }
        }
        if let x = x, let y = y {
            return Piece(width: pieceWidth, height: pieceHeight, x: x, y: y, id: id)
        }
        return nil
    }

    func move(piece: Piece) -> [Board] {
        var boards = [Board]()
        moveLeftPiece(piece: piece).flatMap { boards.append ($0) }
        moveRightPiece(piece: piece).flatMap { boards.append ($0) }
        moveTopPiece(piece: piece).flatMap { boards.append ($0) }
        moveBottomPiece(piece: piece).flatMap { boards.append ($0) }
        return boards
    }
    
    func printBoard() {
        print("current board")
        (0..<board.count).forEach { i in
            print(board[i])
        }
    }
    
    private func moveLeftPiece(piece: Piece) -> Board? {
        guard piece.x != 0 else {
            return nil
        }
        let left = board[piece.y][piece.x - 1]
        if let leftNeighbour = getPiece(left),
            leftNeighbour.isMovable,
            let arrr = leftNeighbour.goRight(on: self) {
                return Board(board: arrr, prevBoards: self.prevBoards + [self])
            }
        
        return nil
    }
    
    private func moveRightPiece(piece: Piece) -> Board? {
        guard piece.x + piece.width < board.first!.count else {
            return nil
        }
        let right = board[piece.y][piece.x + piece.width]
        if let rightNeighbour = getPiece(right),
            rightNeighbour.isMovable,
            let arrr = rightNeighbour.goLeft(on: self)  {
                return Board(board: arrr, prevBoards: self.prevBoards + [self])
        }
        return nil
    }
    
    private func moveTopPiece(piece: Piece) -> Board? {
        guard piece.y > 0 else {
            return nil
        }
        let top = board[piece.y - 1][piece.x]
        if let topNeighbour = getPiece(top),
            topNeighbour.isMovable,
            let arrr = topNeighbour.goDown(on: self)  {
            return Board(board: arrr, prevBoards: self.prevBoards + [self])
        }
        return nil
    }
    
    private func moveBottomPiece(piece: Piece) -> Board? {
        guard piece.y + piece.height < board.count else {
            return nil
        }
        let bottom = board[piece.y + piece.height][piece.x]
        if let bottomNeighbour = getPiece(bottom),
            bottomNeighbour.isMovable,
            let arrr = bottomNeighbour.goUp(on: self)  {
            return Board(board: arrr, prevBoards: self.prevBoards + [self])
        }
        return nil
    }
}

extension Board: Hashable {
    static func == (lhs: Board, rhs: Board) -> Bool {
        for i in 0..<lhs.typeBoard.count {
            for j in 0..<lhs.typeBoard[i].count {
                if lhs.typeBoard[i][j] != rhs.typeBoard[i][j] {
                    return false
                }
            }
        }
        return true
    }
    
    var hashValue: Int {
        return typeBoard.description.hashValue
    }
}

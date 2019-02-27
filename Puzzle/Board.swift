//
//  Board.swift
//  Test
//
//  Created by Elene Akhvlediani on 2/18/19.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation

let b = 3
let z = 30
let space = 1

extension String {
    func substring(_ from: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(startIndex, offsetBy: from + 1)
        return String(self[start ..< end])
    }
}

struct Board: Hashable {
    static let solvedPiece = Piece(width: 2, height: 2, x: 1, y: 3, id: 3)
    var typeBoard: [[Int8]]!
  
    var hashValue: Int {
        return typeBoard.description.hashValue
    }
    
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
    var board: [[Int]] = [[Int]]()
    var prevBoards = [Board]()
    
    var isSolved: Bool {
        let b = getPiece(3)
        return b?.x == 1 && b?.y == 3
    }
    
    lazy var spaces: [Piece] = findSpaces()
    
    init(board: [[Int]]) {
        self.board = board
        typeBoard = board.map { arr -> [Int8] in
            arr.map { $0.toType }
        }
    }
    
    init(texts: [String]) {
        var b = [[Int]]()
        for i in 0..<texts.count {
            var newArr = [Int]()
            let str = texts[i]
            for j in 0..<texts[i].count {
                let subs = str.substring(j)
                newArr.append(subs.toInt)
            }
            b.append(newArr)
        }
        self.init(board: b)
        printBoard()
    }
    
    private func findSpaces() -> [Piece] {
        var spaces = [Piece]()
        (0..<board[0].count).forEach { j in
            (0..<board.count).forEach { i in
                if board[i][j] == space {
                    spaces.append(Piece(width: 1, height: 1, x: j, y: i, id: space))
                }
            }
        }
        return spaces
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
                    if id != space {
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
    
    func printBoard() {
        print("current board")
        (0..<board.count).forEach { i in
            print(board[i])
        }
    }
    
    func move(piece: Piece) -> [Board] {
        var boards = [Board]()
        moveLeftPiece(piece: piece).flatMap { boards.append ($0) }
        moveRightPiece(piece: piece).flatMap { boards.append ($0) }
        moveTopPiece(piece: piece).flatMap { boards.append ($0) }
        moveBottomPiece(piece: piece).flatMap { boards.append ($0) }
        return boards
    }
    
    private func moveLeftPiece(piece: Piece) -> Board? {
        guard piece.x != 0 else {
            return nil
        }
        let left = board[piece.y][piece.x - 1]
        if let leftNeighbour = getPiece(left),
            leftNeighbour.isMovable,
            let arrr = leftNeighbour.goRight(on: self) {
                var new = Board(board: arrr)
                new.prevBoards = self.prevBoards + [self]
                return new
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
                var new = Board(board: arrr)
                new.prevBoards = self.prevBoards + [self]
                return new
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
            var new = Board(board: arrr)
            new.prevBoards = self.prevBoards + [self]
            return new
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
            var new = Board(board: arrr)
            new.prevBoards = self.prevBoards + [self]
            return new
        }
        return nil
    }

}

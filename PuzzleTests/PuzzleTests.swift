//
//  PuzzleTests.swift
//  PuzzleTests
//
//  Created by Elene Akhvlediani on 2/18/19.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import XCTest
@testable import Puzzle

class PuzzleTests: XCTestCase {

    func testCreateBoard() {
        let board = Board(texts: ["22 ","34 "])
        let a = board.getPiece(2)!
        XCTAssertEqual(a.x, 0)
        XCTAssertEqual(a.y, 0)
        let secondBoard = Board(texts: [" 22"," 34"])
        let newA = secondBoard.getPiece(2)!
        XCTAssertEqual(newA.x, 1)
        XCTAssertEqual(newA.y, 0)
    }
    
    func testMoveRight() {
        var board = Board(texts: ["32 ","42 "])
        var right = board.getPiece(2)!.goRight(on: board)
        var newA = Board(board: right!).getPiece(2)!
        XCTAssertEqual(newA.x, 2)
        XCTAssertEqual(newA.y, 0)
        XCTAssertNil(newA.goRight(on: Board(board: right!)))
        board = Board(texts: ["22 ","34 "])
        right = board.getPiece(2)!.goRight(on: board)
        newA = Board(board: right!).getPiece(2)!
        XCTAssertEqual(newA.x, 1)
        XCTAssertEqual(newA.y, 0)
        board = Board(texts: ["22 ","22 "])
        right = board.getPiece(2)!.goRight(on: board)
        newA = Board(board: right!).getPiece(2)!
        XCTAssertEqual(newA.x, 1)
        XCTAssertEqual(newA.y, 0)
    }
    
    func testMoveLeft() {
        var board = Board(texts: [" 23"," 24"])
        var left = board.getPiece(2)!.goLeft(on: board)
        var newA = Board(board: left!).getPiece(2)!
        XCTAssertEqual(newA.x, 0)
        XCTAssertEqual(newA.y, 0)
        XCTAssertNil(newA.goLeft(on: Board(board: left!)))
        board = Board(texts: [" 22"," 34"])
        left = board.getPiece(2)!.goLeft(on: board)
        newA = Board(board: left!).getPiece(2)!
        XCTAssertEqual(newA.x, 0)
        XCTAssertEqual(newA.y, 0)
        board = Board(texts: ["3 22","4 22"])
        left = board.getPiece(2)!.goLeft(on: board)
        newA = Board(board: left!).getPiece(2)!
        XCTAssertEqual(newA.x, 1)
        XCTAssertEqual(newA.y, 0)
    }
    
    func testMoveDown() {
        var board = Board(texts: ["223","  4"])
        var down = board.getPiece(2)!.goDown(on: board)
        var newA = Board(board: down!).getPiece(2)!
        XCTAssertEqual(newA.x, 0)
        XCTAssertEqual(newA.y, 1)
        XCTAssertNil(newA.goDown(on: Board(board: down!)))
        board = Board(texts: ["234","236","  7"])
        down = board.getPiece(2)!.goDown(on: board)
        newA = Board(board: down!).getPiece(2)!
        XCTAssertEqual(newA.x, 0)
        XCTAssertEqual(newA.y, 1)
        board = Board(texts: ["345","322","7  "])
        down = board.getPiece(2)!.goDown(on: board)
        newA = Board(board: down!).getPiece(2)!
        Board(board: down!).printBoard()
        XCTAssertEqual(newA.x, 1)
        XCTAssertEqual(newA.y, 2)
        board = Board(texts: ["22","22", "  "])
        down = board.getPiece(2)!.goDown(on: board)
        newA = Board(board: down!).getPiece(2)!
        XCTAssertEqual(newA.x, 0)
        XCTAssertEqual(newA.y, 1)
    }
    
    func testMoveUp() {
        var board = Board(texts: ["  4", "223"])
        var up = board.getPiece(2)!.goUp(on: board)
        var newA = Board(board: up!).getPiece(2)!
        XCTAssertEqual(newA.x, 0)
        XCTAssertEqual(newA.y, 0)
        XCTAssertNil(newA.goUp(on: Board(board: up!)))
        board = Board(texts: ["  4","627","928"])
        up = board.getPiece(2)!.goUp(on: board)
        newA = Board(board: up!).getPiece(2)!
        XCTAssertEqual(newA.x, 1)
        XCTAssertEqual(newA.y, 0)
        board = Board(texts: [" 34"," 34","266", "266"])
        up = board.getPiece(2)!.goUp(on: board)
        newA = Board(board: up!).getPiece(2)!
        XCTAssertEqual(newA.x, 0)
        XCTAssertEqual(newA.y, 0)
    }
    
    func testOnRealBoardDown() {
        let board = Board(texts: ["abbc", "abbc", "ee f", "dghf", "di j"])
        let down = board.getPiece("b".toInt)!.goDown(on: board)
        XCTAssertNil(down)
    }

    func testOnRealBoardRight() {
        let board = Board(texts: ["abbc", "abbc", "deef", "d hf","ig j"])
        let up = board.getPiece("d".toInt)!.goRight(on: board)
        XCTAssertNil(up)
    }

    func testSpaces(){
        var board = Board(texts: ["abbc", "abbc", "deef", "dghf","i  j"])
        XCTAssertEqual(board.spaces.count, 2)
    }
    
    func testToInt() {
        XCTAssertEqual("a".toInt, 1)
        XCTAssertEqual(" ".toInt, 0)
    }
    
    func testRealExample() {
        let board = Board(texts: ["abbc", "abbc", "deef", "dghf","i  j"])
        let solver = Solver(board: board, targetPiece: Piece(width: 2, height: 2, x: 1, y: 3, title: "b"))
        XCTAssertEqual(solver.solvePuzzle()!.count, 93)
    }
    
    func testOnNonSolveableBoard() {
        let board = Board(texts: ["ighj", "bbcf", "bbcf", "d  a","deea"])
        let solver = Solver(board: board, targetPiece: Piece(width: 2, height: 2, x: 1, y: 3, title: "b"))
        XCTAssertNil(solver.solvePuzzle())
    }
}

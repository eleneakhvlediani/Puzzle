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
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateBoard() {
        let board = Board(texts: ["22 ","34 "])
        let a = board.get(2)!
        XCTAssertEqual(a.x, 0)
        XCTAssertEqual(a.y, 0)
        let secondBoard = Board(texts: [" 22"," 34"])
        let newA = secondBoard.get(2)!
        XCTAssertEqual(newA.x, 1)
        XCTAssertEqual(newA.y, 0)
    }
    
    func testMoveRight() {
        var board = Board(texts: ["32 ","42 "])
        var right = board.get(2)!.goRight(on: board)
        var newA = Board(board: right!).get(2)!
        XCTAssertEqual(newA.x, 2)
        XCTAssertEqual(newA.y, 0)
        XCTAssertNil(newA.goRight(on: Board(board: right!)))
        board = Board(texts: ["22 ","34 "])
        right = board.get(2)!.goRight(on: board)
        newA = Board(board: right!).get(2)!
        XCTAssertEqual(newA.x, 1)
        XCTAssertEqual(newA.y, 0)
        board = Board(texts: ["22 ","22 "])
        right = board.get(2)!.goRight(on: board)
        newA = Board(board: right!).get(2)!
        XCTAssertEqual(newA.x, 1)
        XCTAssertEqual(newA.y, 0)
    }
    
    func testMoveLeft() {
        var board = Board(texts: [" 23"," 24"])
        var left = board.get(2)!.goLeft(on: board)
        var newA = Board(board: left!).get(2)!
        XCTAssertEqual(newA.x, 0)
        XCTAssertEqual(newA.y, 0)
        XCTAssertNil(newA.goLeft(on: Board(board: left!)))
        board = Board(texts: [" 22"," 34"])
        left = board.get(2)!.goLeft(on: board)
        newA = Board(board: left!).get(2)!
        XCTAssertEqual(newA.x, 0)
        XCTAssertEqual(newA.y, 0)
        board = Board(texts: ["3 22","4 22"])
        left = board.get(2)!.goLeft(on: board)
        newA = Board(board: left!).get(2)!
        XCTAssertEqual(newA.x, 1)
        XCTAssertEqual(newA.y, 0)
    }
    
    func testMoveDown() {
        var board = Board(texts: ["223","  4"])
        var down = board.get(2)!.goDown(on: board)
        var newA = Board(board: down!).get(2)!
        XCTAssertEqual(newA.x, 0)
        XCTAssertEqual(newA.y, 1)
        XCTAssertNil(newA.goDown(on: Board(board: down!)))
        board = Board(texts: ["234","236","  7"])
        down = board.get(2)!.goDown(on: board)
        newA = Board(board: down!).get(2)!
        XCTAssertEqual(newA.x, 0)
        XCTAssertEqual(newA.y, 1)
        board = Board(texts: ["345","322","7  "])
        down = board.get(2)!.goDown(on: board)
        newA = Board(board: down!).get(2)!
        Board(board: down!).printBoard()
        XCTAssertEqual(newA.x, 1)
        XCTAssertEqual(newA.y, 2)
        board = Board(texts: ["22","22", "  "])
        down = board.get(2)!.goDown(on: board)
        newA = Board(board: down!).get(2)!
        XCTAssertEqual(newA.x, 0)
        XCTAssertEqual(newA.y, 1)
    }
    
    func testMoveUp() {
        var board = Board(texts: ["  4", "223"])
        var up = board.get(2)!.goUp(on: board)
        var newA = Board(board: up!).get(2)!
        XCTAssertEqual(newA.x, 0)
        XCTAssertEqual(newA.y, 0)
        XCTAssertNil(newA.goUp(on: Board(board: up!)))
        board = Board(texts: ["  4","627","928"])
        up = board.get(2)!.goUp(on: board)
        newA = Board(board: up!).get(2)!
        XCTAssertEqual(newA.x, 1)
        XCTAssertEqual(newA.y, 0)
        board = Board(texts: [" 34"," 34","266", "266"])
        up = board.get(2)!.goUp(on: board)
        newA = Board(board: up!).get(2)!
        XCTAssertEqual(newA.x, 0)
        XCTAssertEqual(newA.y, 1)
    }
    
    func testOnRealBoardDown() {
        let board = Board(texts: ["abbc", "abbc", "ee f", "dghf", "di j"])
        let down = board.get("b".toInt)!.goDown(on: board)
        XCTAssertNil(down)
    }

    func testOnRealBoardRight() {
        let board = Board(texts: ["abbc", "abbc", "deef", "d hf","ig j"])
        let up = board.get("d".toInt)!.goRight(on: board)
        XCTAssertNil(up)
    }

    func testSpaces(){
        let board = Board(texts: ["abbc", "abbc", "deef", "dghf","i  j"])
        XCTAssertEqual(board.spaces.count, 2)
    }
    
    func testToInt() {
        XCTAssertEqual("a".toInt, 2)
        XCTAssertEqual(" ".toInt, 1)
    }
    
    func testPerformanceExample() {
        let board = Board(texts: ["abbc", "abbc", "deef", "dghf","i  j"])
        let solve = Solver.shared.search(board: board)
        XCTAssert(solve!.count > 0)
    }
    
}

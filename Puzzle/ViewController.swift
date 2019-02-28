//
//  ViewController.swift
//  Puzzle
//
//  Created by Elene Akhvlediani on 2/18/19.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var pieceView: PieceView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let board = Board(texts: ["abbc", "abbc", "deef", "dghf","i  j"])
        let solver = Solver(board: board,
                            targetPiece: Piece(width: 2, height: 2, x: 1, y: 3, title: "b"))
        let boards = solver.solvePuzzle()
        pieceView = PieceView(board: board.board)
        pieceView.frame = CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width - 40, height: 500)
        view.addSubview(pieceView)
        updateBoard(boards: boards!, pos: 0)
    }
    
    func updateBoard(boards: [Board], pos: Int) {
        if pos == boards.count {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.pieceView.updateBoard(to: boards[pos].board)
            self.updateBoard(boards: boards, pos: pos + 1)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


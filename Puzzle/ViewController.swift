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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var solveButton: UIButton!
    let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        pieceView = PieceView()
        pieceView.isHidden = true
        pieceView.frame = CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width - 40, height: 500)
        view.addSubview(pieceView)
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
    
    @IBAction func solveButtonClicked(_ sender: UIButton) {
        sender.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        viewModel.solve { [weak self] boards in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.pieceView.isHidden = false
                self?.updateBoard(boards: boards, pos: 0)
            }
        }
    }
}


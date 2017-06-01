//
//  ViewController.swift
//  TicTacToeFlux
//
//  Created by Benji Encz on 5/21/17.
//  Copyright © 2017 Benjamin Encz. All rights reserved.
//

import UIKit

class TicTacToeViewController: UIViewController {

    @IBOutlet var instructionLabel: UILabel!
    var store: TicTacToeStore!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.store = TicTacToeStore() { [unowned self] newState in
            self.instructionLabel.text = newState.gameInstruction
            self.connect4View.board = newState.game.board
        }

        self.connect4View.buttonTappedClosure = { index in
            self.store.handleAction(action: .placeToken(atIndex: index))
        }
    }

    @IBAction func undoTapped(_ sender: Any) {
        self.store.handleAction(action: .undo)
    }

    @IBAction func redoTapped(_ sender: Any) {
        self.store.handleAction(action: .redo)
    }


    // MARK: View Setup

    lazy var connect4View: TicTacToeView = {
        let view = Bundle.main.loadNibNamed(
            "TicTacToeView", owner: nil, options: nil
            )?.first as! TicTacToeView

        view.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.size.width,
            height: self.view.frame.size.width
        )
        view.center = self.view.center
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(view)

        view.board = Board()
        view.backgroundColor = .clear
        
        return view
    }()
    
}



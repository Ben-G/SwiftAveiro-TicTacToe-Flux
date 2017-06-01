//
//  TicTacToeView.swift
//  TicTacToeFlux
//
//  Created by Benji Encz on 5/21/17.
//  Copyright © 2017 Benjamin Encz. All rights reserved.
//

import UIKit

final class TicTacToeView: UIView {

    var buttonTappedClosure: ((Int) -> ())?

    /// This naughtily relies on the implementation detail that
    /// outlet collections are ordered based on the order in which
    /// outlets were added; but this is just a quick example project
    /// after all...
    @IBOutlet var fieldButtons: [UIButton]! {
        didSet {
            for (index, button) in fieldButtons.enumerated() {
                button.tag = index
                button.addTarget(
                    self,
                    action: #selector(TicTacToeView.buttonTapped(sender:)),
                    for: .touchUpInside
                )
            }
        }
    }

    var board: Board? {
        didSet {
            guard let board = board else { return }

            for (index, token) in board.tokens.enumerated() {
                fieldButtons[index].setTitle(token.rawValue, for: .normal)
            }
        }
    }

    func buttonTapped(sender: UIButton) {
        self.buttonTappedClosure?(sender.tag)
    }
    
}

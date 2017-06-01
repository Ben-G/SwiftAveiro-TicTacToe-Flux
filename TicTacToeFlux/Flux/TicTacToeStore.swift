//
//  TicTacToeStore.swift
//  TicTacToeFlux
//
//  Created by Benji Encz on 5/21/17.
//  Copyright © 2017 Benjamin Encz. All rights reserved.
//

import Foundation

final class TicTacToeStore {

    var states: [TicTacToeState] = []

    var state: TicTacToeState {
        didSet {
            self.onStateChange(state)
            if !isUndoing {
                self.states.append(state)
                self.stateIndex += 1
            }
        }
    }

    var isUndoing = false
    var stateIndex = 0

    var onStateChange: (TicTacToeState) -> ()

    init(onStateChange: @escaping (TicTacToeState) -> ()) {
        self.onStateChange = onStateChange
        self.state = TicTacToeState(
            gameInstruction: "Let's begin!",
            game: Game()
        )
        // Send initial state
        self.onStateChange(self.state)
        self.states.append(self.state)
    }

    func handleAction(action: TicTacToeActions) {
        switch action {
        case let .placeToken(atIndex: index):
            self.placeToken(atIndex: index)
        case .undo:
            self.undo()
        case .redo:
            self.redo()
        }
    }

    func placeToken(atIndex index: Int) {
        let movePossible = self.state.game.attemptPlacing(atIndex: index)
        if !movePossible {
            self.state.gameInstruction = "Move is not possible! Place \(self.state.game.currentPlayer.rawValue) again."
        } else {
            self.state.gameInstruction = "Place an \(self.state.game.currentPlayer.rawValue)"
        }

        if let winner = self.state.game.winner {
            self.state.gameInstruction = "Player \(winner) Wins!!"
        }
    }

    func undo() {
        guard self.stateIndex > 0 else { return }

        self.isUndoing = true
        self.state = self.states[self.stateIndex - 1]
        self.stateIndex -= 1
        self.isUndoing = false
    }

    func redo() {
        guard self.stateIndex < (self.states.count - 1) else { return }

        self.isUndoing = true
        self.state = self.states[self.stateIndex + 1]
        self.stateIndex += 1
        self.isUndoing = false
    }
    
}


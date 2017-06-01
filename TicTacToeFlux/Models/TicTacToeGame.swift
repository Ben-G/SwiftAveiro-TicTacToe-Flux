//
//  TicTacToeGame.swift
//  TicTacToeFlux
//
//  Created by Benji Encz on 5/21/17.
//  Copyright © 2017 Benjamin Encz. All rights reserved.
//

import Foundation

enum Token: String {
    case empty
    case x
    case o
}

struct Board {
    var tokens: [Token]

    init() {
        self.tokens = Array(repeating: Token.empty, count: 9)
    }

    mutating func attemptPlacing(token: Token, atIndex: Int) -> Bool {
        if self.tokens[atIndex] == .empty {
            self.tokens[atIndex] = token
            return true
        } else {
            return false
        }
    }

    subscript(row: Int, column: Int) -> Token {
        return self.tokens[row * 3 + column]
    }

}

struct Game {
    /// A board with 9 tokens.
    var board: Board
    // Representing a player by their token is a shortcut
    // for this sample project that isn't entirely correct.
    var currentPlayer: Token
    var winner: Token?

    init() {
        self.board = Board()
        self.currentPlayer = .x
    }

    mutating func attemptPlacing(atIndex index: Int) -> Bool {
        let success = self.board.attemptPlacing(token: self.currentPlayer, atIndex: index)

        if success {
            self.currentPlayer = self.currentPlayer == .x ? .o : .x
            self.winner = self.checkWinner()
        }

        return success
    }

    func checkWinner() -> Token? {
        // Check winning options
        for option in Game.winningOptions {
            var currentToken: Token?
            for (solutionIndex, tokenIndex) in option.enumerated() {
                if let token = currentToken {
                    if self.board.tokens[tokenIndex] != token {
                        break
                    }
                } else {
                    currentToken = self.board.tokens[tokenIndex]
                }

                if solutionIndex == option.count - 1 && currentToken != .empty {
                    return currentToken
                }
            }
        }

        return nil
    }

    static let winningOptions = [
        // Horizontal
        [0,1,2],
        [3,4,5],
        [6,7,8],
        // Vertical
        [0,3,6],
        [1,4,7],
        [2,5,8],
        // Diagonal
        [0,4,8],
        [2,4,6]
    ]
}



//
//  TicTacToeActions.swift
//  TicTacToeFlux
//
//  Created by Benji Encz on 5/21/17.
//  Copyright © 2017 Benjamin Encz. All rights reserved.
//

import Foundation

enum TicTacToeActions {
    case placeToken(atIndex: Int)
    case undo
    case redo
}

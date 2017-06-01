//
//  TicTacToeFluxTests.swift
//  TicTacToeFluxTests
//
//  Created by Benji Encz on 5/21/17.
//  Copyright © 2017 Benjamin Encz. All rights reserved.
//

import XCTest
@testable import TicTacToeFlux

class TicTacToeFluxTests: XCTestCase {
    
    func testInitialState() {
        let store = TicTacToeStore { _ in }
        XCTAssertEqual(store.state.gameInstruction, "Let's begin!")
    }

    func testHandlesTokenPlacement() {
        let store = TicTacToeStore { _ in }
        store.handleAction(action: .placeToken(atIndex: 0))

        XCTAssertEqual(store.state.gameInstruction, "Place an o")
    }

    func testCanUndo() {
        let store = TicTacToeStore { _ in }
        store.handleAction(action: .placeToken(atIndex: 0))
        store.handleAction(action: .undo)
        store.handleAction(action: .undo)

        XCTAssertEqual(store.state.gameInstruction, "Let's begin!")
    }
    
}

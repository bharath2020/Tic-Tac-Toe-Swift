//
//  TTBoardTests.swift
//  Tic-Tac-Toe-Swift
//
//  Created by Bharath Booshan on 9/12/15.
//  Copyright (c) 2015 FeatherTouch. All rights reserved.
//

import UIKit
import XCTest


class TTBoardTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIfBoardReturnsCorrectEmptySlots() {
        
        let board   = TTBoard(boardIDString: NSUUID().UUIDString)
        board.markPosition(0, playerCode: 1);
        board.markPosition(2, playerCode: 2);
        
        let emptySlots = board.getEmptySpotList()
        let expectedSlots = [ 1,3,4,5,6,7,8]
        XCTAssertEqual(emptySlots,expectedSlots,"empty slots not equal");
        
    }
    
    func testWinnerHorizontally(){
        
        let board = TTBoard(boardIDString: NSUUID().UUIDString)
        
        board.markPosition(0, playerCode: 1);
        board.markPosition(3, playerCode: 2);
        board.markPosition(1, playerCode: 1);
        board.markPosition(5, playerCode: 2);
        board.markPosition(2, playerCode: 1);
        
        let winner = board.winner()
        let expectedWinner = 1;
        XCTAssertEqual(winner, expectedWinner, "Failed Horizontal Winner");
        
    }
    
    func testWinnerDiagonally(){
        let board = TTBoard(boardIDString: NSUUID().UUIDString)
        board.markPosition(0, playerCode: 1);
        board.markPosition(1, playerCode: 2);
        board.markPosition(4, playerCode: 1);
        board.markPosition(2, playerCode: 2);
        board.markPosition(8, playerCode: 1);
        
        
        let winner = board.winner()
        let expectedWinner = 1;
        XCTAssertEqual(expectedWinner, winner, "Failed Winner Diagonally")
    }
    
    func testWinnerReverseDiagonally(){
        
        let board = TTBoard(boardIDString: NSUUID().UUIDString)
        
        board.markPosition(2, playerCode: 1)
        board.markPosition(1, playerCode: 2)
        board.markPosition(4, playerCode: 1)
        board.markPosition(5, playerCode: 2)
        board.markPosition(6, playerCode: 1)
        
        
        let winner = board.winner()
        let expectedWinner = 1
        XCTAssertEqual(expectedWinner, winner, "Failed Winner Reverse Diagonally")
        
        
    }
    
    

}

//
//  TTBoard.swift
//  Tic-Tac-Toe-Swift
//
//  Created by Bharath Booshan on 9/12/15.
//  Copyright (c) 2015 FeatherTouch. All rights reserved.
//

import Foundation
import UIKit

enum BoardState {
    case Win
    case Complete
    case InComplete
}

let NOT_OCCUPIED = -1

let  win:[Int] = [0,1,2,3,4,5,6,7,8,0,3,6,1,4,7,2,5,8,0,4,8,2,4,6];

final class TTBoard {
    private var board : [Int] = []
    private var totalPiecesOnBoard = 0
    private var emptySpots : [Int] = []
    let boardID : String
    
    init(boardIDString : String) {
    
    self.boardID = boardIDString
        for pos in 0...8 {
            board.append( NOT_OCCUPIED )
            emptySpots.append(pos)
        }
    }
    
    func getBoardID() -> String {
        return self.boardID
    }
    
    final func markPosition(position : Int , playerCode  : Int ) -> BoardState {
        assert(position < 9, "Position greater than 9 while marking position")
        if board[position] != NOT_OCCUPIED {
            return .InComplete
        }
        
        board[position] = playerCode
        removePositionFromEmptySlot(position)
        totalPiecesOnBoard++

        let boardState:Int = winner()
        if boardState != 0 {
            return .Win
        }
        else if isBoardComplete() {
            return .Complete
        }
        else{
            return .InComplete
        }
    }
    
    func getEmptySpotList() -> [Int] {
       return Array<Int>(emptySpots)
    }
    
    func removePositionFromEmptySlot(position : Int ){
        //remove from empty slots
        if let index = emptySpots.indexOf(position) {
        emptySpots.removeAtIndex(index)
        }
    }
    
    func addPositionToEmptySlot(position : Int ){
        emptySpots.append(position)
    }
    
    func resetPosition( position : Int ){
        assert(position<9, "Position greater than 9 while resetting")
        board[position] = NOT_OCCUPIED
        addPositionToEmptySlot(position)
        totalPiecesOnBoard--
    }
    
     func winner( ) -> Int {
        //  0 1 2
        //  3 4 5
        //  6 7 8
        
        for index in 0...7 {
            let baseIndex = index * 3
            let valAt0 = board[win[baseIndex]]
            if( valAt0 != NOT_OCCUPIED &&
                valAt0 == board[win[baseIndex+1]]  &&
                valAt0 == board[win[baseIndex+2]]){
                    return valAt0;
            }
        }
        return 0;
    }
    
    func isBoardEmpty() -> Bool {
        return totalPiecesOnBoard == 0;
    }
    
    func isBoardComplete() -> Bool {
        return totalPiecesOnBoard == 9
    }
    
    func isEqualToBoard( otherBoard : TTBoard ) -> Bool {
        return boardID == otherBoard.boardID
    }
    
    func resetBoard() -> Void {
        for _ in 0...8 {
            board.append(NOT_OCCUPIED)
        }
        totalPiecesOnBoard=0
    }
    
    func copyBoardFrom(otherBoard: [Int], emptySpotsCopy  : [Int]   ) -> Void{
        let boardCount = otherBoard.count
        board.removeAll(keepCapacity: true)
        for position in 0...boardCount-1 {
            board.append(otherBoard[position])
        }
        
        emptySpots.removeAll(keepCapacity: true)
        for val in emptySpotsCopy{
            emptySpots.append(val)
        }
    }
    
    func copy() -> TTBoard {
        let copy = TTBoard(boardIDString: self.boardID)
        copy.copyBoardFrom(board,emptySpotsCopy: emptySpots)
        copy.totalPiecesOnBoard = self.totalPiecesOnBoard
        return copy
    }
}

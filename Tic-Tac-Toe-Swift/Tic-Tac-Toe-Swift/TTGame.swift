//
//  TTPlayer.swift
//  Tic-Tac-Toe-Swift
//
//  Created by Bharath Booshan on 9/12/15.
//  Copyright (c) 2015 FeatherTouch. All rights reserved.
//

import Foundation
import UIKit

let TTGameStartedNotificationKey = "TTGameStartedNotificationKey"
let TTGameEndedNotificationKey = "TTGameEndedNotificationKey"
let TTGameIsTieKey = "TTGameIsTieKey"

let TTGamePositionUpdatedKey = "TTGamePositionUpdatedKey"
let TTGamePlayerKey = "TTGamePlayerKey"
let TTGamePositionKey = "TTGamePositionKey"

final class TTGame  {
    
    private let _player1 : TTPlayer
    private let _player2 : TTPlayer
    var _currentPlayer : TTPlayer
    let _currentBoard : TTBoard
    
    
    
    
    init(player1 : TTPlayer , player2 : TTPlayer, currentPlayer : TTPlayer ){
        
        _player1 = player1
        _player2 = player2
        _currentPlayer = currentPlayer
        
        _player1.playerCode = 1
        _player2.playerCode = 2
        
        _currentBoard = TTBoard(boardIDString: NSUUID().UUIDString)
        
    }
    
    func startGame() -> Void {
        
        NSNotificationCenter.defaultCenter().postNotificationName(TTGameStartedNotificationKey, object: self);
        
        let delayInSeconds = 0.1
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue(), {
                [unowned self ] in
                
                self._currentPlayer.yourTurn()
        })
      
    }
    
    
    func markPosition(position : Int ) -> Bool {
        
        var returnState : Bool = false
        
        let boardState = _currentBoard.markPosition(position, playerCode: _currentPlayer.playerCode )
        
        NSNotificationCenter.defaultCenter().postNotificationName(TTGamePositionUpdatedKey, object: self, userInfo: [TTGamePlayerKey : _currentPlayer, TTGamePositionKey : position])
        
        switch ( boardState ){
            
        case .InComplete:
            
        _currentPlayer =  ( _currentPlayer === _player1 ) ? _player2 : _player1
            _currentPlayer.yourTurn()
            
        case .Complete:
            _player1.youAreTied()
            _player2.youAreTied()
            gameEnded(true)
            returnState = true
        
        default:
            _currentPlayer.youWin()
            gameEnded(false)
            returnState = true
            
        }
        
        return returnState
        
    }
    
    func gameEnded(didEnd : Bool) -> Void {
      
        NSNotificationCenter.defaultCenter().postNotificationName(TTGameEndedNotificationKey, object: self, userInfo: [TTGameIsTieKey : NSNumber(bool: didEnd) , TTGamePlayerKey : _currentPlayer])
    
    }
    
    
    func winner() -> TTPlayer! {
        
        let state = _currentBoard.winner();
        if state == _player1.playerCode {
            return _player1
        }
        else if state == _player2.playerCode {
            return _player2
        }
        
        return nil
        
    }
}
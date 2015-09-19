//
//  TTSmartPlayer.swift
//  Tic-Tac-Toe-Swift
//
//  Created by Bharath Booshan on 9/12/15.
//  Copyright (c) 2015 FeatherTouch. All rights reserved.
//

import Foundation

let TTSmartPlayerPredictedNextPositionKey = "TTSmartPlayerPredictedNextPositionKey"

let TTSmartPlayerPosition = "TTSmartPlayerPosition"

final class TTSmartPlayer  : TTPlayer {
 
    private var opponentPlayer : TTPlayer
    private var board : TTBoard?
    private var _AI : TTGameAI?
     init(opponent: TTPlayer )  {
        self.opponentPlayer = opponent
        super.init()
        //AI needs to know the host and opponent
        _AI = TTGameAI(hostPlayer: self, opponent: self.opponentPlayer)
        self.smart = true
        
    }
    
    
    
    override func yourTurn() {
        
        super.yourTurn()
        
        _AI!.predictNextPositiion(forBoard: self.board!, completion: { ( position  : Int , boardInContext : TTBoard )  -> Void in
            
            if self.board!.isEqualToBoard(boardInContext) {
                
                NSNotificationCenter.defaultCenter().postNotificationName(TTSmartPlayerPredictedNextPositionKey, object: self, userInfo: [TTSmartPlayerPosition : position])
                
            }
            
        });
        
    }
    
    
    func assignBoard(_board : TTBoard? ){
        board = _board
    }
    
}
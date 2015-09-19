//
//  TTGameAI.swift
//  Tic-Tac-Toe-Swift
//
//  Created by Bharath Booshan on 9/12/15.
//  Copyright (c) 2015 FeatherTouch. All rights reserved.
//

import Foundation


let MAX_LEVELS = 10
let cornerSlots  : [Int] = [0,2,6,8]

final class TTGameAI  {
    
    private let hostPlayer : TTPlayer
    private let opponent : TTPlayer
    
    
    func rand(from : Int , to : Int ) -> Int {
        return from
        
      // return Int(arc4random_uniform( UInt32(to - from + 1 )))
    }
    
    init(hostPlayer player1: TTPlayer , opponent player2 : TTPlayer ){
        
        hostPlayer = player1
        opponent = player2
    }
    
    func predictNextPositiion(forBoard board: TTBoard, completion : (Int , TTBoard ) -> Void ){
        
        let boardCopy = board.copy() 
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { [unowned self ]() -> Void in
            
            var position = -1
            
            //If Smart player is making the first move, then chose corner sides, as this move will always result in a win, except in case where the opponent
            // places his next move in center

            if boardCopy.isBoardEmpty() {
                position = cornerSlots[self.rand(0, to: 3)]
            }
            else{
                
                //Apply MiniMax Algorithm
                // Loop through empty slots and find out the maximum score the smart player can score on each of next available moves
                // Select the score which returns the maximum score
                
                var emptySlots = boardCopy.getEmptySpotList()
                
                if emptySlots.count != 0 {
                    
                    var maxScore = -MAX_LEVELS
                    
                    while emptySlots.count != 0 {
                        
                        let totalSlots = emptySlots.count
                        let nextIndex = self.rand(0, to: totalSlots-1)
                        
                        let positionNum = emptySlots[nextIndex]
                        
                        emptySlots.removeAtIndex(nextIndex)
                        
                        boardCopy.markPosition(positionNum, playerCode: self.hostPlayer.playerCode)
                        
                        let tempScore = self.getBestScore(self.hostPlayer, inBoard: boardCopy, depth: 0)
                        
                        boardCopy.resetPosition(positionNum)
                        
                        
                        if maxScore  < tempScore {
                            maxScore = tempScore
                            position = positionNum
                        }
                        
                    }
                    
                }

                
                
                
            }
            
            //Flush the result on a main thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(position,boardCopy);
                });
            
            
        })
        
    }
    
    
    //minmax algorithm to predict best score for given tic tac toe game status
    //This alogrithm tries to create a Game Tree for each of the  available moves
    //This is a recursive function trying to create a a game board simulating player turns
    //Predicts the best score for each player
    //Since we want to predict the move for Smartest player, We derive scores from Smart Player's perspective
    //If Smart Player wins, we will take the maximum score, while if the opponent wins, the score will be negative, indicating the maximum loss for the smart player. ZERO if the game is tied

    
    func getBestScore(currentPlayer : TTPlayer , inBoard board:TTBoard , depth : Int ) -> Int{
        
        let state = board.winner()
        
        if state == self.hostPlayer.playerCode {
            return MAX_LEVELS - depth
        }
        else if state == self.opponent.playerCode {
            return depth - MAX_LEVELS
        }
        
        var emptySlots = board.getEmptySpotList();
        
        //No Empty slots means, that the game board must be full and we will take this as a tie.
        // hence return ZERO

        if emptySlots.count == 0 {
            return 0;
        }
        
        var minScore = MAX_LEVELS, maxScore = -MAX_LEVELS
        
        
        //ITs time for the next player's turn.
        // Find the best score for the 'nextPlayer'
        
        let nextPlayer = ( currentPlayer === self.hostPlayer) ? opponent : hostPlayer;
        
        var nextIndex = 0
        let totalEmptySlots = emptySlots.count
        
        while nextIndex < totalEmptySlots {
            //let totalSlots = emptySlots.count
            //let nextIndex = rand(0, to: totalSlots-1)
            
            let position = emptySlots[nextIndex]
            
            nextIndex = nextIndex + 1
            //emptySlots.removeAtIndex(nextIndex)
            
            
            board.markPosition(position, playerCode: nextPlayer.playerCode )
            
            let score = getBestScore(nextPlayer, inBoard: board, depth: depth+1)
            
            //Now that we have found the score for this postion, we move to next empty slot
            // resetting this position, so that it is becomes available
            
            board.resetPosition(position)
            
            if minScore > score {
                minScore = score
            }
            
            if maxScore < score {
                maxScore = score
            }
            
            
        }
        
        //This is the key
        // We take positive score if the host player wins.
        if nextPlayer === self.hostPlayer {
            return maxScore
        }
        
        return minScore
    }
    
    
    
    
}
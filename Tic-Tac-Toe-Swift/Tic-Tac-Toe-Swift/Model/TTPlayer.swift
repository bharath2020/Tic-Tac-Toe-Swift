//
//  TTPlayer.swift
//  Tic-Tac-Toe-Swift
//
//  Created by Bharath Booshan on 9/12/15.
//  Copyright (c) 2015 FeatherTouch. All rights reserved.
//

import Foundation
import UIKit

let TTPlayerTurnNotificationKey = "turn"

class TTPlayer {
    
    
    var smart = false
    var name = ""
    var playerCode = 0
    var color : UIColor?
    
    
    
    func yourTurn() -> Void {
        
        NSNotificationCenter.defaultCenter().postNotificationName(TTPlayerTurnNotificationKey, object: self);
    }
    
    func youWin() -> Void {
        print("\(name) Won!!");
    }
    
    func youLose() -> Void {
        
    }
    
    func youAreTied() -> Void {
        
    }
    
}
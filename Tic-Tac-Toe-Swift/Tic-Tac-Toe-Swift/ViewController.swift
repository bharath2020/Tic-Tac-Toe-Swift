//
//  ViewController.swift
//  Tic-Tac-Toe-Swift
//
//  Created by Bharath Booshan on 9/12/15.
//  Copyright (c) 2015 FeatherTouch. All rights reserved.
//

import UIKit

class ViewController: UIViewController,TTViewDelegate {
    
    
    @IBOutlet weak var mTTView : TTView?
    @IBOutlet weak var mPlayer1NameField : UILabel?
    @IBOutlet weak var mPlayer2NameField : UILabel?
    @IBOutlet weak var mGameResultLabel : UILabel?
    @IBOutlet weak var mComputerTurnButton : UILabel?
    @IBOutlet weak var mHumanTurnButton : UIButton?
    
    
    private var _currentGame : TTGame?
    private var _humanPlayer : TTPlayer
    private var _smartPlayer : TTSmartPlayer
    
    
    private func refreshScreen(){
        
        if _currentGame == nil {
            mGameResultLabel?.text = "Will you Start?"
            mHumanTurnButton?.enabled = true
            mComputerTurnButton?.enabled = true
        }
        else {
            
            let playerName = _currentGame!._currentPlayer.name
            mGameResultLabel?.text = "Its \(playerName)'s Turn"
        }
        
    }
    
    private func registerForEvents(){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("gamePositionUpdated:"), name: TTGamePositionUpdatedKey, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("gameEnded:"), name: TTGameEndedNotificationKey, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("smartPlayerNextMove:"), name: TTSmartPlayerPredictedNextPositionKey, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("playerTurnChanged:"), name: TTPlayerTurnNotificationKey, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("newGameStarted:"), name: TTGameStartedNotificationKey, object: nil)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {

        //Since we are not doing any player management, we stick to two players for now
        _humanPlayer = TTPlayer()
        _humanPlayer.name = "Human"
        _humanPlayer.color = UIColor.lightGrayColor()
        
        
        _smartPlayer = TTSmartPlayer(opponent: _humanPlayer)
        _smartPlayer.name = UIDevice.currentDevice().model
        _smartPlayer.color = UIColor.darkGrayColor()
        
        super.init(coder: aDecoder)
        
        registerForEvents()
        refreshScreen()
        
    }
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
       

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mTTView!.delegate = self
        mPlayer1NameField?.text = _humanPlayer.name
        mPlayer2NameField?.text = _smartPlayer.name
        
        refreshScreen()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func iWillStartAction(sender : AnyObject){
        
        _currentGame = TTGame(player1: _humanPlayer, player2: _smartPlayer, currentPlayer: _humanPlayer)
        _currentGame?.startGame()
    }
    
    @IBAction func youWillStartAction(sender : AnyObject ) {
        
        _currentGame = TTGame(player1: _humanPlayer, player2: _smartPlayer, currentPlayer: _smartPlayer)
        _currentGame?.startGame()
        
    }
    
    func didTap( ttView : TTView , atPosition : Int ){
        if _currentGame?._currentPlayer === _humanPlayer {
            _currentGame?.markPosition(atPosition)
        }
    }

    
    func newGameStarted(notif :  NSNotification){
        self.mTTView?.reset()
        _smartPlayer.assignBoard((_currentGame?._currentBoard)!)
        refreshScreen()
    }

    func gameEnded(notif : NSNotification){
        
        let userInfoDict:[NSObject : AnyObject] = notif.userInfo!
        let isTied = userInfoDict[TTGameIsTieKey] as! Bool
        
        if  isTied == false {
            
            let winner : TTPlayer = userInfoDict[TTGamePlayerKey] as! TTPlayer
            if winner.smart {
                mGameResultLabel?.text = "Try Again.. Will you Start?"
            }
            else{
                let playerName = winner.name
                mGameResultLabel?.text = "Miracle - \(playerName) - You Made It!!"
            }
            
        }
        else {
            
            mGameResultLabel?.text = "Its a Tie!! Shall I Start?"
        }
        
        _currentGame = nil
        _smartPlayer.assignBoard(nil) 
        mComputerTurnButton?.enabled = true
        mHumanTurnButton?.enabled = true
        
    }
    
    func gamePositionUpdated(notif : NSNotification ){
        
        let userInfoDict : [NSObject : AnyObject ] = notif.userInfo!
        let player  = userInfoDict[TTGamePlayerKey] as! TTPlayer
        let position = userInfoDict[TTGamePositionKey] as! Int
        mTTView?.mark(player.color!, position: position)
        refreshScreen()
        
    }
    
    
    func playerTurnChanged(notif : NSNotification ) {
        
        refreshScreen()
        
    }
    
    func smartPlayerNextMove(notif : NSNotification){
        
        let userInfoDict : [NSObject : AnyObject] = notif.userInfo!
        if _currentGame?._currentPlayer === _smartPlayer {
            let nextPosition = userInfoDict[TTSmartPlayerPosition] as! Int
            _currentGame?.markPosition(nextPosition)
            
        }
        
    }
    
}


//
//  TTView.swift
//  Tic-Tac-Toe-Swift
//
//  Created by Bharath Booshan on 9/12/15.
//  Copyright (c) 2015 FeatherTouch. All rights reserved.
//

import Foundation
import UIKit



protocol TTViewDelegate : class, NSObjectProtocol {
    
    func didTap( ttView : TTView , atPosition : Int );
}

class TTView : UIView {
    
    weak var delegate : TTViewDelegate?
    var tapLayers : Array <CALayer>

    
    required init?(coder aDecoder: NSCoder) {
        
        self.tapLayers = Array<CALayer>()

        super.init(coder: aDecoder)
        
        createTicTacToeMatrixViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("tapGesture:"))
        
        addGestureRecognizer(tapGesture)
        
    }
    
    
    
    func createTicTacToeMatrixViews() -> Void {
        
        let width = self.bounds.size.width / 3.0
        let height = self.bounds.size.height / 3.0
        var yPos = Float(0.0)
        
        for _ in 0...2 {
            
            
            for col in 0...2 {
                
                let layer = CALayer()
                let x = CGFloat(col) * width
                layer.frame = CGRectMake(x, CGFloat(yPos), width, CGFloat(height))
                layer.borderWidth = 1.0
                layer.borderColor = UIColor.orangeColor().CGColor
                layer.backgroundColor = UIColor.whiteColor().CGColor
                tapLayers.append(layer)
                self.layer.addSublayer(layer)
                
                
            }
            
            yPos += Float(height);
            
        }
        
        
    }
    
    
    func mark(color : UIColor , position : Int ){
        if position < tapLayers.count {
            let layer = tapLayers[position]
            layer.backgroundColor = color.CGColor
        }
    }
    
    func reset() {
        
        for layer in tapLayers {
            layer.backgroundColor = UIColor.whiteColor().CGColor
        }
    }
    
    func tapGesture(gesture : UIGestureRecognizer) {
        
        let pointInBounds = gesture.locationInView(self)
        
        
        for pos in 0...tapLayers.count-1 {
            
            let layer = tapLayers[pos]
            
            if CGRectContainsPoint(layer.frame, pointInBounds) {
                delegate!.didTap(self, atPosition: pos)
                break
            }
        }
        
        
    }
    
}
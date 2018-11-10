//
//  ShelvesView.swift
//  grower
//
//  Created by Diheng Qu on 11/9/18.
//  Copyright © 2018 Diheng Qu. All rights reserved.
//

import UIKit

class ShelvesView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        
        let origin = CGPoint(x: 20, y: 150)
        let h = CGFloat(400)
        let w = CGFloat(250)
        let d = CGFloat(180)
      
        
        // Drawing code
        let f1 = origin
        let f2 = CGPoint(x: f1.x + w, y: f1.y)
        let f3 = CGPoint(x: f1.x + w, y: f1.y+h)
        let f4 = CGPoint(x: f1.x, y: f1.y + h)
        
        let a = d / CGFloat(2).squareRoot()
        
        let b1 = CGPoint(x: f1.x + a, y: f1.y - a)
        let b2 = CGPoint(x: f2.x + a, y: f2.y - a)
        let b3 = CGPoint(x: f3.x + a, y: f3.y - a)
        let b4 = CGPoint(x: f4.x + a, y: f4.y - a)
        
        let fl1 = CGPoint(x: f1.x,y:f1.y + h/4)
        let fl2 = CGPoint(x: b1.x, y: b1.y + h/4)
        let fl3 = CGPoint(x: fl2.x + h/4 , y: fl2.y )
        let fl4 = CGPoint(x: fl1.x + h/4, y: fl1.y)
        
        let bl1 = CGPoint(x: f1.x ,y:f1.y + 3*h/4 + 10)
        let bl2 = CGPoint(x: b1.x , y: b1.y + 3*h/4 + 10)
        let bl3 = CGPoint(x: bl2.x + h/4 , y: bl2.y )
        let bl4 = CGPoint(x: bl1.x + h/4, y: bl1.y)
        
        
        // Draw side and fill

        let _ = drawSide(f4,f1,b1,b4,UIColor.green)
        let _ = drawSide(fl1, fl2, fl3, fl4, UIColor.green)
        let _ = drawSide(bl1, bl2, bl3, bl4, UIColor.green)
        
        
    }
}

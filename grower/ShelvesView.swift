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
        
        let origin = CGPoint(x: 40, y: 150)
        let h = CGFloat(400)
        let d = CGFloat(180)
        
        // Drawing code
        let f1 = origin
        let f4 = CGPoint(x: f1.x, y: f1.y + h)
        
        let a = d / CGFloat(2).squareRoot()
        let b1 = CGPoint(x: f1.x + a, y: f1.y - a)
        let b4 = CGPoint(x: f4.x + a, y: f4.y - a)
        
        // Draw side and fill

        let _ = drawSide(f4,f1,b1,b4,UIColor.green)
    }
}

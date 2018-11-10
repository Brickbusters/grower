//
//  MonitorView.swift
//  grower
//
//  Created by Diheng Qu on 11/9/18.
//  Copyright © 2018 Diheng Qu. All rights reserved.
//

import UIKit

class MonitorView: UIView {
   
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
     let topleft = CGPoint (x: 50, y: 100)
     let h = CGFloat(500)
     let w = CGFloat(150)
     let bottomleft = CGPoint(x: topleft.x,y: topleft.y + h)
     let bottomright = CGPoint(x: bottomleft.x + w, y: bottomleft.y)
     let topright = CGPoint(x: topleft.x + w, y: topleft.y)
        let side = UIBezierPath()
        side.move(to: topleft)
        side.addLine(to: bottomleft)
        side.addLine(to: bottomright)
        side.addLine(to: topright)
        
        UIColor.black.setStroke()
        side.stroke()
        
    }
    

}

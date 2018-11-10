//
//  GuiUtil.swift
//  grower
//
//  Created by Diheng Qu on 11/9/18.
//  Copyright © 2018 Diheng Qu. All rights reserved.
//

import Foundation
import UIKit

func drawSide(_ p1: CGPoint, _ p2: CGPoint, _ p3: CGPoint, _ p4: CGPoint,_ color: UIColor) -> UIBezierPath {
    let side = UIBezierPath()
    
    side.move(to: p1)
    side.addLine(to: p2)
    side.addLine(to: p3)
    side.addLine(to: p4)
    side.close()
    
    UIColor.black.setStroke()
    side.stroke()
    color.setFill()
    side.fill()
    
    return side
}

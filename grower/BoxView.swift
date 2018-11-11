//
//  BoxView.swift
//  grower
//
//  Created by Diheng Qu on 11/9/18.
//  Copyright © 2018 Diheng Qu. All rights reserved.
//

import UIKit

class BoxView: UIView {
    let origin = CGPoint(x: 50, y: 400)
    let h = CGFloat(200)
    let w = CGFloat(250)
    let d = CGFloat(180)
    let t = CGFloat(180 * 1.2)
    let plantCaption = UILabel()
    
    
    var plantInBox : Plant?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    

    let growerData = GrowerDatabase()
    
    var lidOpen = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
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
        
        let l1 = CGPoint(x: b1.x, y: b1.y - t)
        let l2 = CGPoint(x: b2.x, y: b2.y - t)
        
       // Draw back side and fill
        let _ = drawSide(b1, b2, b3, b4, UIColor.lightGray)
        let _ = drawSide(f3,f4,b4,b3,UIColor.darkGray)
        let _ = drawSide(f2,f3,b3,b2,UIColor.green)
        let _ = drawSide(f4,f1,b1,b4,UIColor.gray)
        let _ = drawSide(f1, f2, f3, f4, UIColor.green)
        
        if lidOpen {
            let _ = drawSide(b1,b2,l2,l1,UIColor.lightGray)
        } else{
            let _ = drawSide(f1,f2,b2,b1,UIColor.green)
        }
        if let plant = plantInBox {
            displayLabel(label: plantCaption, text: plant.rawValue, x: 50,
                         y: 400, width: w, height: h)
        } else {
            plantCaption.removeFromSuperview()
        }
    }
    func displayLabel(label: UILabel, text: String,
                      x: CGFloat, y: CGFloat,
                      width: CGFloat, height: CGFloat) {
        addSubview(label)
        label.text = text
        label.font = label.font.withSize(60)
        label.frame = CGRect(x: x, y: y, width: width, height: height)
        label.center = CGPoint(x: x + width / 2, y: y + height / 2)
        label.textAlignment = .right
        label.setNeedsDisplay()
    }
}

//
//  MonitorView.swift
//  grower
//
//  Created by Diheng Qu on 11/9/18.
//  Copyright © 2018 Diheng Qu. All rights reserved.
//

import UIKit

class MonitorView: UIView {
    let topleft = CGPoint (x: 45, y: 180)
    let h = CGFloat(400)
    let w = CGFloat(130)
    let barWidth = CGFloat(130/8) // temperature and light status bar width
    let lowestTemp = CGFloat(40)
    let highestTemp = CGFloat(90)
    let lowestLux = CGFloat(0)
    let highestLux = CGFloat(2000)

    var tempLabel90 = UILabel()
    var tempLabel80 = UILabel()
    var tempLabel70 = UILabel()
    var tempLabel60 = UILabel()
    var tempLabel50 = UILabel()
    
    var luxLabel2000 = UILabel()
    var luxLabel1500 = UILabel()
    var luxLabel1000 = UILabel()
    var luxLabel500 = UILabel()
    
    var dayLabel = UILabel()
    var resultLabel = UILabel()
    
    var temperature: UInt = 40 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lux: UInt = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    func displayLabel(label: UILabel, text: String,
                      x: CGFloat, y: CGFloat,
                      width: CGFloat, height: CGFloat) {
        addSubview(label)
        label.text = text
        label.frame = CGRect(x: x, y: y, width: width, height: height)
        label.center = CGPoint(x: x + width / 2, y: y + height / 2)
        label.textAlignment = .right
        label.setNeedsDisplay()
    }
    
    func getTempBarHeight() -> CGFloat {
        let tempRange = highestTemp - lowestTemp
        return (CGFloat(temperature) - lowestTemp) / tempRange * h
    }
    
    func getLuxBarHeight() -> CGFloat {
        let luxRange = highestLux - lowestLux
        return (CGFloat(lux) - lowestLux) / luxRange * h
    }
    
    func drawStatusBar(base: CGPoint, height: CGFloat, color: UIColor) {
        let bar = UIBezierPath()
        
        bar.move(to: base)
        bar.addLine(to: CGPoint(x: base.x + barWidth, y: base.y))
        bar.addLine(to: CGPoint(x: base.x + barWidth, y: base.y - height))
        bar.addLine(to: CGPoint(x: base.x, y: base.y - height))
        bar.close()
        
        color.setFill()
        bar.fill()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let bottomleft = CGPoint(x: topleft.x,y: topleft.y + h)
        let bottomright = CGPoint(x: bottomleft.x + w, y: bottomleft.y)
        let topright = CGPoint(x: topleft.x + w, y: topleft.y)
        let side = UIBezierPath()
        side.move(to: topleft)
        side.addLine(to: bottomleft)
        side.addLine(to: bottomright)
        side.addLine(to: topright)
        let t80 = CGPoint(x: topleft.x, y: topleft.y + h/5)
        let t70 = CGPoint(x: t80.x, y: t80.y + h/5)
        let t60 = CGPoint(x: t70.x, y: t70.y + h/5)
        let t50 = CGPoint(x: t60.x, y: t60.y + h/5)
        
        side.move(to: t80)
        side.addLine(to: CGPoint(x: t80.x - 10, y: t80.y))
        side.move(to: t70)
        side.addLine(to: CGPoint(x: t70.x - 10, y: t70.y))
        side.move(to: t60)
        side.addLine(to: CGPoint(x: t60.x - 10, y: t60.y))
        side.move(to: t50)
        side.addLine(to: CGPoint(x: t50.x - 10, y: t50.y))
        side.move(to: topleft)
        side.addLine(to: CGPoint(x: topleft.x - 10, y: topleft.y))
        side.move(to: bottomleft)
        side.addLine(to: CGPoint(x: bottomleft.x - 10, y: bottomleft.y))
        
        let l1500 = CGPoint(x: topright.x, y: topright.y + h/4)
        let l1000 = CGPoint(x: l1500.x, y: l1500.y + h/4)
        let l500 = CGPoint(x: l1000.x, y: l1000.y + h/4)
        let l0 = CGPoint(x: l500.x, y: l500.y + h/4)
        
        side.move(to: l1500)
        side.addLine(to: CGPoint(x: l1500.x + 10, y: l1500.y))
        side.move(to: l1000)
        side.addLine(to: CGPoint(x: l1000.x + 10, y: l1000.y))
        side.move(to: l500)
        side.addLine(to: CGPoint(x: l500.x + 10, y: l500.y))
        side.move(to: l0)
        side.addLine(to: CGPoint(x: l0.x + 10, y: l0.y))
        side.move(to: topright)
        side.addLine(to: CGPoint(x: topright.x + 10, y: topright.y))
        side.move(to: bottomright)
        side.addLine(to: CGPoint(x: bottomright.x + 10, y: bottomright.y))
        UIColor.black.setStroke()
        side.stroke()
        
        displayLabel(label: tempLabel90, text: "90",
                     x: topleft.x - 45, y: topleft.y - 20, width: 35, height: 40)
        displayLabel(label: tempLabel80, text: "80",
                     x: t80.x - 45, y: t80.y - 20, width: 35, height: 40)
        displayLabel(label: tempLabel70, text: "70",
                     x: t70.x - 45, y: t70.y - 20, width: 35, height: 40)
        displayLabel(label: tempLabel60, text: "60",
                     x: t60.x - 45, y: t60.y - 20, width: 35, height: 40)
        displayLabel(label: tempLabel50, text: "50",
                     x: t50.x - 45, y: t50.y - 20, width: 35, height: 40)
        
        
        displayLabel(label: luxLabel2000, text: "2000",
                     x: topright.x + 11, y: topright.y - 20, width: 50, height: 40)
        displayLabel(label: luxLabel1500, text: "1500",
                     x: l1500.x + 11, y: l1500.y - 20, width: 50, height: 40)
        displayLabel(label: luxLabel1000, text: "1000",
                     x: l1000.x + 11, y: l1000.y - 20, width: 50, height: 40)
        displayLabel(label: luxLabel500, text: "500",
                     x: l500.x + 11, y: l500.y - 20, width: 40, height: 40)

        let tempBarBase = CGPoint(x: bottomleft.x + w * 2 / 8, y: bottomleft.y)
        drawStatusBar(base: tempBarBase, height: getTempBarHeight(), color: UIColor.red)
        let luxBarBase = CGPoint(x: bottomleft.x + w * 5 / 8, y: bottomleft.y)
        drawStatusBar(base: luxBarBase, height: getLuxBarHeight(), color: UIColor.blue)
    }
}

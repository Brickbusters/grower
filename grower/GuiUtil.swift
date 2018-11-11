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

func getHue(red: CGFloat, green: CGFloat, blue: CGFloat) -> CGFloat
{
    let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
    var hue: CGFloat = 0
    color.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
    return hue
}

func chromaKeyFilter(fromHue: CGFloat, toHue: CGFloat) -> CIFilter?
{
    // 1
    let size = 64
    var cubeRGB = [Float]()
    
    // 2
    for z in 0 ..< size {
        let blue = CGFloat(z) / CGFloat(size-1)
        for y in 0 ..< size {
            let green = CGFloat(y) / CGFloat(size-1)
            for x in 0 ..< size {
                let red = CGFloat(x) / CGFloat(size-1)
                
                // 3
                let hue = getHue(red: red, green: green, blue: blue)
                let alpha: CGFloat = (hue >= fromHue && hue <= toHue) ? 0: 1
                
                // 4
                cubeRGB.append(Float(red * alpha))
                cubeRGB.append(Float(green * alpha))
                cubeRGB.append(Float(blue * alpha))
                cubeRGB.append(Float(alpha))
            }
        }
    }
    
    let data = Data(buffer: UnsafeBufferPointer(start: &cubeRGB, count: cubeRGB.count))
    
    // 5
    let colorCubeFilter = CIFilter(name: "CIColorCube", withInputParameters: ["inputCubeDimension": size, "inputCubeData": data])
    return colorCubeFilter
}

func filterBlueBackground(_ originalUIImage: UIImage) -> UIImage {
    let originalCIImage = CIImage(image: originalUIImage)
    let chromaCIFilter = chromaKeyFilter(fromHue: 0.60, toHue: 0.65)
    
    chromaCIFilter?.setValue(originalCIImage, forKey: kCIInputImageKey)
    
    let filteredCIImage = chromaCIFilter?.outputImage
    let filteredUIImage = UIImage(ciImage: filteredCIImage!)
    
    return filteredUIImage
}

//
//  GrowerData.swift
//  grower
//
//  Created by Diheng Qu on 11/9/18.
//  Copyright © 2018 Diheng Qu. All rights reserved.
//

import Foundation

/*
 * Data Types
 */
enum Plant : String {
    case Kale
    case Blueberry
}

enum Condition {
    case Died
    case Survived
    case Thrived
}

struct EnvDataPoint: CustomStringConvertible {
    // in unit of lux
    var brightness: UInt
    // in unit of fahrenheit
    var temp: UInt
    
    public var description: String {
        return "(\(brightness), \(temp))"
    }
}

struct Experiment: CustomStringConvertible {
    var plant: Plant
    var light: UInt
    var result: Condition
    var measurements: [EnvDataPoint] // assume one data point every 12 hours
    
    public var description: String {
        return "\(plant) + \(light): \(measurements)"
    }
}

/*
 * Data collected from experiments
 */
// TODO - read from file or google doc
let box: [(UInt, Condition, Condition)] = [
    (80, Condition.Survived, Condition.Survived),
    (120, Condition.Survived, Condition.Survived),
    (160, Condition.Died, Condition.Died),
    (200, Condition.Died, Condition.Died)
]

// Each column "box1 (brightnewss, temp)", "box2 (brightness, temp)", ..
let data: [[(UInt, UInt)]] = [
    [(200, 75), (500, 75), (1200, 75), (2000, 75)], // day 1
    [(0, 65), (0, 65), (0, 65), (0, 65)],
    [(200, 75), (500, 75), (1200, 75), (2000, 75)], // day 2
    [(0, 65), (0, 65), (0, 65), (0, 65)],
    [(200, 75), (500, 75), (1200, 75), (2000, 75)], // day 3
    [(0, 65), (0, 65), (0, 65), (0, 65)],
    [(200, 75), (500, 75), (1200, 75), (2000, 75)], // day 4
    [(0, 65), (0, 65), (0, 65), (0, 65)],
    [(200, 75), (500, 75), (1200, 75), (2000, 75)], // day 5
    [(0, 65), (0, 65), (0, 65), (0, 65)],
    [(200, 75), (500, 75), (1200, 75), (2000, 75)], // day 6
    [(0, 65), (0, 65), (0, 65), (0, 65)],
    [(200, 75), (500, 75), (1200, 75), (2000, 75)], // day 7
    [(0, 65), (0, 65), (0, 65), (0, 65)]
]

/*
 * Popluate data model
 */
class GrowerDatabase {
    var experiments: [Plant: [UInt: Experiment]] = [
        Plant.Kale: [UInt: Experiment](),
        Plant.Blueberry: [UInt: Experiment]()
    ]

    init() {
        for index in 0..<4 {
            //let power = box[index].0
            //let kaleCondition = box[index].1
            //let bbCondition = box[index].2
            
            let (power, kaleCondition, bbCondition) = box[index]
            
            experiments[Plant.Kale]![power] = Experiment(
                plant: Plant.Kale,
                light: power,
                result: kaleCondition,
                measurements: [EnvDataPoint]()
            )
            
            experiments[Plant.Blueberry]![power] = Experiment(
                plant: Plant.Blueberry,
                light: power,
                result: bbCondition,
                measurements: [EnvDataPoint]()
            )
        }
        
        for line in data {
            for index in 0..<4 {
                let power = box[index].0
                let temp = line[index].0
                let lux = line[index].1
                
                experiments[Plant.Kale]![power]!.measurements.append(
                    EnvDataPoint(brightness: lux, temp: temp))
                experiments[Plant.Blueberry]![power]!.measurements.append(
                    EnvDataPoint(brightness: lux, temp: temp))
            }
        }
    }
}



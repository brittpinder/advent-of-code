//
//  01.swift
//
//
//  Created by Brittany Pinder on 2021-08-18.
//

import Foundation

struct Point: Hashable {
    var x: Int
    var y: Int

    static func +(lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

func getInstructions(wire: String.SubSequence) -> [(direction: String, amount: Int)] {
    return wire.split(separator: ",").map {
        (direction: String($0.first!), amount: Int($0.dropFirst())!)
    }
}

func getCoordinates(wire: [(direction: String, amount: Int)]) -> [Point] {
    var coordinates: [Point] = []
    
    var position = Point(x: 0, y: 0)
    var facingDirection = Point(x: 0, y: 0)
    
    for instruction in wire {
        switch instruction.direction {
            case "R": facingDirection = Point(x: 1, y: 0)
            case "L": facingDirection = Point(x: -1, y: 0)
            case "U": facingDirection = Point(x: 0, y: -1)
            case "D": facingDirection = Point(x: 0, y: 1)
            default:
                assert(false, "Unknown direction encountered!")
                continue
        }
        
        for _ in 0..<instruction.amount {
            position = position + facingDirection
            coordinates.append(position)
        }
    }
    
    return coordinates
}


let contents = try! String(contentsOfFile: "Input")

let wires = contents.split(separator: "\n")
assert(wires.count == 2, "Should have exactly two wires!")

let wireInstructions1 = getInstructions(wire: wires[0])
let wireInstructions2 = getInstructions(wire: wires[1])

let wireCoordinates1 = getCoordinates(wire: wireInstructions1)
let wireCoordinates2 = getCoordinates(wire: wireInstructions2)

let intersections = Array(Set(wireCoordinates1).intersection(Set(wireCoordinates2)))
let distances = intersections.map { abs($0.x) + abs($0.y) }.sorted()
let closestIntersection = distances[0]

print("Distance to closest intersection is \(closestIntersection)")
assert(closestIntersection == 1211, "Answer is incorrect!")

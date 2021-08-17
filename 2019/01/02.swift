//
//  02.swift
//
//
//  Created by Brittany Pinder on 2021-08-17.
//

import Foundation

let contents = try! String(contentsOfFile: "Input")
let modules = contents.split(separator:"\n")
                      .compactMap { Int($0) }

func calculateFuel(mass: Int) -> Int {
    let fuel = max(mass / 3 - 2, 0)
    return fuel + (fuel > 0 ? calculateFuel(mass: fuel) : 0)
}

let totalFuel = modules.map { calculateFuel(mass: $0) }
                       .reduce(0, +)

print(totalFuel)

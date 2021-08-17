//
//  01.swift
//
//
//  Created by Brittany Pinder on 2021-08-17.
//

import Foundation

let contents = try! String(contentsOfFile: "Input")
let modules = contents.split(separator:"\n")
                      .compactMap { Int($0) }

var totalFuel = modules.map { $0 / 3 - 2 }
                       .reduce(0, +)

print(totalFuel)

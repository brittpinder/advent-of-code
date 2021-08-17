//
//  01.swift
//
//
//  Created by Brittany Pinder on 2021-08-17.
//

import Foundation

let contents = try! String(contentsOfFile: "Input")
let lines = contents.split(separator:"\n")
                    .compactMap { Int($0) }

var visited = Set<Int>()
var answer: Int? = nil

for entry in lines {
    if visited.contains(2020 - entry) {
        answer = entry * (2020 - entry)
        break
    } else {
        visited.insert(entry)
    }
}

print(answer ?? "Answer not found!")

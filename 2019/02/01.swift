//
//  01.swift
//
//
//  Created by Brittany Pinder on 2021-08-17.
//

import Foundation

let contents = try! String(contentsOfFile: "Input")

let trimmedContents = contents.replacingOccurrences(of: "\n", with: "")

var codes = trimmedContents.split(separator:",")
                           .compactMap { Int($0) }

codes[1] = 12
codes[2] = 2

for (index, code) in codes.enumerated() where index % 4 == 0 {

    if code == 99 {
        break
    }

    let position1 = codes[index + 1]
    let position2 = codes[index + 2]
    let position3 = codes[index + 3]

    switch code {
        case 1:
            codes[position3] = codes[position1] + codes[position2]
        case 2:
            codes[position3] = codes[position1] * codes[position2]
        default:
            print("Unknown opcode encountered")
    }

}

let answer = codes[0]
print(answer)
assert(answer == 2842648, "Answer is incorrect!")

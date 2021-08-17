//
//  02.swift
//
//
//  Created by Brittany Pinder on 2021-08-17.
//

import Foundation

func runProgram(program: [Int], noun: Int, verb: Int) -> Int {
    var codes = program

    codes[1] = noun
    codes[2] = verb

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

    return codes[0]
}

let contents = try! String(contentsOfFile: "Input")

let trimmedContents = contents.replacingOccurrences(of: "\n", with: "")

var codes = trimmedContents.split(separator:",")
                           .compactMap { Int($0) }

var answer: Int? = nil

for noun in 0...99 {
    for verb in 0...99 {
        if (runProgram(program: codes, noun: noun, verb: verb)) == 19690720 {
            answer = 100 * noun + verb
        }
    }
}

print(answer ?? "Answer not found!")
assert(answer == 9074, "Answer is incorrect!")

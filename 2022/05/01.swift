import Foundation

func moveCrates1(crates: inout [[Character]], instruction: (move: Int, from: Int, to: Int)) {
    for _ in 0..<instruction.move {
        crates[instruction.to - 1].append(crates[instruction.from - 1].removeLast())
    }
}

func moveCrates2(crates: inout [[Character]], instruction: (move: Int, from: Int, to: Int)) {
    let from = instruction.from - 1
    let to = instruction.to - 1
    let startIndex = crates[from].count - instruction.move
    let endIndex = crates[from].count - 1

    crates[to] += crates[from][startIndex...endIndex]
    crates[from].removeSubrange(startIndex...endIndex)
}

let contents = try! String(contentsOfFile: "input").split(separator: "\n\n")

// Parse crate data
let rows = contents[0].split(separator: "\n")
var stacks = [[Character]]()

for rowIndex in (0..<rows.count).reversed() {
    let row = rows[rowIndex]

    var stackIndex = 0
    for i in stride(from: 1, through: row.count, by: 4) {
        if stacks.count < stackIndex + 1 {
            stacks.append([])
        }

        let column = row.index(row.startIndex, offsetBy: i)
        let char = row[column]
        if char.isLetter {
            stacks[stackIndex].append(char)
        }
        stackIndex += 1
    }
}

let originalCrates = stacks

// Parse instructions
let instructions = contents[1].split(separator: "\n")
                              .map{$0.split(separator: " ")}
                              .map{(move: Int($0[1])!, from: Int($0[3])!, to: Int($0[5])!)}

// Part 1
var crates: [[Character]] = originalCrates.map{$0}

for step in instructions {
    moveCrates1(crates: &crates, instruction: step)
}

let answer1 = crates.map{String($0.last!)}
                    .joined()
print(answer1)
assert(answer1 == "TPGVQPFDH", "Wrong answer! Expected TPGVQPFDH")

// Part 2
crates = originalCrates.map{$0}

for step in instructions {
    moveCrates2(crates: &crates, instruction: step)
}

let answer2 = crates.map{String($0.last!)}
                    .joined()
print(answer2)
assert(answer2 == "DMRDFRHHH", "Wrong answer! Expected DMRDFRHHH")

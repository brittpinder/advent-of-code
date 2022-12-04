import Foundation

let contents = try! String(contentsOfFile: "input")

let pairs: [[[Int]]] = contents.split(separator: "\n")
                    .map{$0.split(separator:",")
                        .map{$0.split(separator: "-")
                            .map{Int($0)!}
                        }
                    }

let answer1 = pairs.map{ (pair: [[Int]]) -> Int in
    let first = pair[0][0]...pair[0][1]
    let second = pair[1][0]...pair[1][1]
    return first.contains(second) || second.contains(first) ? 1 : 0
}.reduce (0, +)

print(answer1)
assert(answer1 == 595, "Wrong answer! Expected 595")

let answer2 = pairs.map{ (pair: [[Int]]) -> Int in
    let first = pair[0][0]...pair[0][1]
    let second = pair[1][0]...pair[1][1]
    return first.overlaps(second) ? 1 : 0
}.reduce (0, +)

print(answer2)
assert(answer2 == 952, "Wrong answer! Expected 952")

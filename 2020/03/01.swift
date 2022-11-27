import Foundation

func countTrees(grid: [[Character]], slopeX: Int, slopeY: Int) -> Int {
    let rowLength = grid[0].count
    let columnLength = grid.count

    var x = 0
    var y = 0
    var numTrees = 0

    while true {
        y += slopeY
        if (y >= columnLength) {
            break
        }

        x += slopeX
        if x >= rowLength {
            x -= rowLength
        }

        if grid[y][x] == "#" {
            numTrees += 1
        }
    }
    return numTrees
}

let contents = try! String(contentsOfFile: "input")
let characters: [[Character]] = contents.split(separator: "\n")
                                        .map{$0.map{$0}}

let answer1 = countTrees(grid: characters, slopeX: 3, slopeY: 1)
print(answer1)
assert(answer1 == 178, "Wrong Answer! Expected 178")

let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
let answer2 = slopes.map{countTrees(grid: characters, slopeX: $0.0, slopeY: $0.1)}
                    .reduce(1, *)
print(answer2)
assert(answer2 == 3492520200, "Wrong Answer! Expected 3492520200")

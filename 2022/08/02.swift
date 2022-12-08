import Foundation

let contents = try! String(contentsOfFile: "input").split(separator: "\n")

var trees: [[Int]] = contents.map{$0.split(separator: "")
                                .map{Int($0)!}
                             }

let width = trees[0].count
let height = trees.count

func getScenicScore(column: Int, row: Int) -> Int {
    let treeHouseHeight = trees[row][column]

    var visibleUp = 0
    for y in stride(from: row - 1, to: -1, by: -1) {
        visibleUp += 1
        if trees[y][column] >= treeHouseHeight {
            break
        }
    }

    var visibleDown = 0
    for y in (row + 1)..<height {
        visibleDown += 1
        if trees[y][column] >= treeHouseHeight {
            break
        }
    }

    var visibleLeft = 0
    for x in stride(from: column - 1, to: -1, by: -1) {
        visibleLeft += 1
        if trees[row][x] >= treeHouseHeight {
            break
        }
    }

    var visibleRight = 0
    for x in (column + 1)..<width {
        visibleRight += 1
        if trees[row][x] >= treeHouseHeight {
            break
        }
    }

    return visibleUp * visibleDown * visibleLeft * visibleRight
}

var highestScore = 0
for x in 0..<width {
    for y in 0..<height {
        let scenicScore = getScenicScore(column: x, row: y)
        if scenicScore > highestScore {
            highestScore = scenicScore
        }
    }
}

print(highestScore)
assert(highestScore == 444528, "Wrong answer! Expected 444528")

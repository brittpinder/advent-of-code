import Foundation

struct Tree {
    let height: Int
    var visible: Bool
}

let contents = try! String(contentsOfFile: "input").split(separator: "\n")

var trees: [[Tree]] = contents.map{$0.split(separator: "")
                                .map{Tree(height: Int($0)!, visible: false)}
                              }

let width = trees[0].count
let height = trees.count

// Check visible from top
for x in 0..<width {
    var maxHeight = -1
    for y in 0..<height {
        let treeHeight = trees[y][x].height
        if treeHeight > maxHeight {
            trees[y][x].visible = true
            maxHeight = treeHeight
            if maxHeight == 9 {
                break
            }
        }
    }
}

// Check visible from bottom
for x in 0..<width {
    var maxHeight = -1
    for y in stride(from: height - 1, to: -1, by: -1) {
        let treeHeight = trees[y][x].height
        if treeHeight > maxHeight {
            trees[y][x].visible = true
            maxHeight = treeHeight
            if maxHeight == 9 {
                break
            }
        }
    }
}

// Check visible from left
for y in 0..<height {
    var maxHeight = -1
    for x in 0..<width {
        let treeHeight = trees[y][x].height
        if treeHeight > maxHeight {
            trees[y][x].visible = true
            maxHeight = treeHeight
            if maxHeight == 9 {
                break
            }
        }
    }
}

// Check visible from right
for y in 0..<height {
    var maxHeight = -1
    for x in stride(from: width - 1, to: -1, by: -1) {
        let treeHeight = trees[y][x].height
        if treeHeight > maxHeight {
            trees[y][x].visible = true
            maxHeight = treeHeight
            if maxHeight == 9 {
                break
            }
        }
    }
}

let answer = trees.joined()
                  .map{$0.visible ? 1 : 0}
                  .reduce(0, +)

print(answer)
assert(answer == 1805, "Wrong answer! Expected 1805")

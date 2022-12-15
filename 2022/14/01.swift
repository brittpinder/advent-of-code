import Foundation

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

enum Material {
    case rock, air, sand
}

struct Position: Hashable {
    var x: Int
    var y: Int

    static func + (left: Position, right: Position) -> Position {
        return Position(x: left.x + right.x, y: left.y + right.y)
    }

    static func - (left: Position, right: Position) -> Position {
        return Position(x: left.x - right.x, y: left.y - right.y)
    }
}

func createCave(rockPaths: [[Position]]) -> [Position : Material] {
    var cave = [Position : Material]()
    for path in rockPaths {
        for index in 0..<path.count - 1 {
            var position = path[index]
            let target = path[index + 1]
            let diff = target - position
            let direction = Position(x: diff.x.clamped(to: -1...1), y: diff.y.clamped(to: -1...1))

            while position != target {
                cave[position] = Material.rock
                position = position + direction
            }
            cave[position] = Material.rock
        }
    }
    return cave
}

func getNumberOfMaterial(cave: [Position : Material], material: Material) -> Int {
    return cave.values.filter({$0 == material}).count
}

func dropSand1(paths: [[Position]], dropPosition: Position) -> Int {
    var cave = createCave(rockPaths: paths)
    let largestHeight = paths.flatMap({$0}).map{$0.y}.sorted().last!

    while true {
        var sandPos = dropPosition

        while true {
            let dropPositions = [Position(x: sandPos.x, y: sandPos.y + 1),
                                 Position(x: sandPos.x - 1, y: sandPos.y + 1),
                                 Position(x: sandPos.x + 1, y: sandPos.y + 1)]

            var sandFell = false
            for dropPosition in dropPositions {
                if dropPosition.y > largestHeight {
                    return getNumberOfMaterial(cave: cave, material: Material.sand)
                } else if cave[dropPosition] == nil {
                    sandPos = dropPosition
                    sandFell = true
                    break
                }
            }
            if !sandFell {
                cave[sandPos] = Material.sand
                break
            }
        }
    }
}

func dropSand2(paths: [[Position]], dropPosition: Position) -> Int {
    var cave = createCave(rockPaths: paths)
    let floorHeight = paths.flatMap({$0}).map{$0.y}.sorted().last! + 2

    func isPositionEmpty(_ position: Position) -> Bool {
        return position.y == floorHeight ? false : cave[position] == nil
    }

    while true {
        var sandPos = dropPosition

        while true {
            let dropPositions = [Position(x: sandPos.x, y: sandPos.y + 1),
                                 Position(x: sandPos.x - 1, y: sandPos.y + 1),
                                 Position(x: sandPos.x + 1, y: sandPos.y + 1)]

            var sandFell = false
            for dropPosition in dropPositions {
                if isPositionEmpty(dropPosition) {
                    sandPos = dropPosition
                    sandFell = true
                    break
                }
            }

            if !sandFell {
                cave[sandPos] = Material.sand
                if sandPos == dropPosition {
                    return getNumberOfMaterial(cave: cave, material: Material.sand)
                }
                break
            }
        }
    }
}

let paths: [[Position]] = try! String(contentsOfFile: "input")
                                .split(separator: "\n")
                                .map{$0.split(separator: " -> ")
                                    .map{$0.split(separator: ",")}
                                    .map{Position(x: Int($0[0])!, y: Int($0[1])!)}
                                }

let answer1 = dropSand1(paths: paths, dropPosition: Position(x: 500, y: 0))
print(answer1)
assert(answer1 == 805, "Wrong answer! Expected 805")

let answer2 = dropSand2(paths: paths, dropPosition: Position(x: 500, y: 0))
print(answer2)
assert(answer2 == 25161, "Wrong answer! Expected 25161")

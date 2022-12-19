import Foundation

struct Position {
    let x: Int
    let y: Int
}

let horizontalLine = [[1,1,1,1]]

let cross = [[0,1,0],
             [1,1,1],
             [0,1,0]]

let corner = [[0,0,1],
              [0,0,1],
              [1,1,1]]

let verticalLine = [[1],
                    [1],
                    [1],
                    [1]]

let square = [[1,1],
              [1,1]]

let shapes: [[[Int]]] = [horizontalLine, cross, corner, verticalLine, square]

func printChamber() {
    for row in chamber {
        print(row.map{$0 == 0 ? ". " : "@ "}.joined())
    }
    print("\n")
}

func getHighestRockY() -> Int {
    for y in 0..<chamber.count {
        if chamber[y].contains(1) {
            return y
        }
    }
    return chamber.count
}

func getHeightOfTower() -> Int {
    return chamber.count - getHighestRockY()
}

func addLineToChamber() {
    chamber.insert([0,0,0,0,0,0,0], at: 0)
}

func placeRock(shape: [[Int]], position: Position) {
    for y in 0..<shape.count {
        for x in 0..<shape[y].count {
            if shape[y][x] == 1 {
                chamber[position.y + y][position.x + x] = 1
            }
        }
    }
}

func canMoveRockToPosition(shape: [[Int]], position: Position) -> Bool {
    for y in 0..<shape.count {
        for x in 0..<shape[y].count {
            if position.y - y >= chamber.count {
                return false
            }
            if position.x + x < 0 || position.x + x >= chamber[0].count {
                return false
            }
            if chamber[position.y + y][position.x + x] == 1 && shape[y][x] == 1 {
                return false
            }
        }
    }
    return true
}

func addRock(shape: [[Int]]) {
    for _ in 0..<(max(0, shape.count + 3 - getHighestRockY())) {
        addLineToChamber()
    }

    var position = Position(x: 2, y: getHighestRockY() - shape.count - 3)

    while true {
        jetIndex = (jetIndex + 1) % jets.count
        let nextJet = jets[jetIndex]

        let positionHorizontal = Position(x: position.x + (nextJet == ">" ? 1 : -1), y: position.y)
        if canMoveRockToPosition(shape: shape, position: positionHorizontal) {
            position = positionHorizontal
        }

        let positionDown = Position(x: position.x, y: position.y + 1)
        if canMoveRockToPosition(shape: shape, position: positionDown) {
            position = positionDown
        } else {
            break
        }
    }

    placeRock(shape: shape, position: position)
}

func getHeightAfterRocks(_ numRocks: Int) -> Int {
    chamber = Array(repeating:[0,0,0,0,0,0,0], count: 4)
    jetIndex = -1
    shapeIndex = -1

    for _ in 0..<numRocks {
        shapeIndex = (shapeIndex + 1) % shapes.count
        addRock(shape: shapes[shapeIndex])
    }
    return getHeightOfTower()
}

let jets = try! String(contentsOfFile: "input").split(separator: "\n")[0].map{$0}
var jetIndex = -1
var shapeIndex = -1
var chamber = Array(repeating:[0,0,0,0,0,0,0], count: 4)

let answer = getHeightAfterRocks(2022)
print(answer)
assert(answer == 3092, "Wrong answer! Expected 3092")

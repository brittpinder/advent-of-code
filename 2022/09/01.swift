import Foundation

let motions = try! String(contentsOfFile: "input")
                    .split(separator: "\n")
                    .map{$0.split(separator: " ")}
                    .map{(direction: String($0[0]), amount: Int($0[1])!)}

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

func arePositionsTouching(pos1: Position, pos2: Position) -> Bool {
    let xDiff = abs(pos1.x - pos2.x)
    let yDiff = abs(pos1.y - pos2.y)
    return xDiff <= 1 && yDiff <= 1
}

func getTailVistedPositions(numKnots: Int) -> Set<Position> {
    var knots: [Position] = Array(repeating: Position(x: 0, y: 0), count: numKnots)
    var tailVisitedPositions: Set<Position> = [knots[knots.count - 1]]

    for motion in motions {
        for _ in 0..<motion.amount {
            // Move the first knot
            switch motion.direction {
                case "U": knots[0].y -= 1
                case "D": knots[0].y += 1
                case "L": knots[0].x -= 1
                case "R": knots[0].x += 1
                default:
                    assertionFailure("Unrecognized direction!")
            }

            // Update the trailing knots
            for i in 1..<knots.count {
                let parentPosition = knots[i - 1]
                let position = knots[i]

                if !arePositionsTouching(pos1: parentPosition, pos2: position) {
                    var requiredMovement = parentPosition - position

                    if requiredMovement.x != 0 {
                        requiredMovement.x /= abs(requiredMovement.x)
                    }
                    if requiredMovement.y != 0 {
                        requiredMovement.y /= abs(requiredMovement.y)
                    }

                    knots[i] = knots[i] + requiredMovement

                    if i == knots.count - 1 {
                        tailVisitedPositions.insert(knots[i])
                    }
                }
            }
        }
    }
    return tailVisitedPositions
}

let answer1 = getTailVistedPositions(numKnots: 2).count
print(answer1)
assert(answer1 == 5619, "Wrong answer! Expected 5619")

let answer2 = getTailVistedPositions(numKnots: 10).count
print(answer2)
assert(answer2 == 2376, "Wrong answer! Expected 2376")

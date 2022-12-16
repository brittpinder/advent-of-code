import Foundation

let start = DispatchTime.now()

struct Position: Hashable {
    var x: Int
    var y: Int
}

struct Range {
    var min: Int
    var max: Int

    func contains(_ other: Range) -> Bool {
        return other.min >= self.min && other.max <= self.max
    }

    func contains(_ num: Int) -> Bool {
        return num >= min && num <= max
    }

    func overlaps(_ other: Range) -> Bool {
        return (self.max <= other.max && self.max >= other.min)
            || (self.min >= other.min && self.min <= other.max)
    }
}

let information: [[[String]]] = try! String(contentsOfFile: "input")
                                    .split(separator: "\n")
                                    .map{$0.split(separator: ":")
                                        .map{$0.split(separator: ", ")
                                            .map{String($0)}
                                        }
                                    }

var sensorInfo = [(sensor: Position, beacon: Position, distance: Int)]()

for info in information {
    let sensor = info[0]
    let sensorX = Int(sensor[0].split(separator: "=")[1])!
    let sensorY = Int(sensor[1].split(separator: "=")[1])!

    let beacon = info[1]
    let beaconX = Int(beacon[0].split(separator: "=")[1])!
    let beaconY = Int(beacon[1].split(separator: "=")[1])!

    let distance = abs(beaconX - sensorX) + abs(beaconY - sensorY)

    sensorInfo.append((sensor: Position(x: sensorX, y: sensorY), beacon: Position(x: beaconX, y: beaconY), distance: distance))
}

func optimizeRanges(_ ranges: [Range]) -> [Range] {
    var newRanges = ranges.sorted{$0.min < $1.min}

    var index = newRanges.startIndex
    while index != newRanges.endIndex - 1 {
        let range1 = newRanges[index]
        let range2 = newRanges[index + 1]
        if range1.contains(range2) || range2.contains(range1) || range1.overlaps(range2) {
            newRanges[index] = Range(min: min(range1.min, range2.min), max: max(range1.max, range2.max))
            newRanges.remove(at: index + 1)
        } else {
            index = newRanges.index(after: index)
        }
    }

    if newRanges.count == ranges.count {
        return newRanges
    }

    return optimizeRanges(newRanges)
}

func getSensorRanges(y: Int) -> [Range] {
    var sensorRanges = [Range]()

    for info in sensorInfo {
        let distanceToLine = abs(y - info.sensor.y)
        if distanceToLine <= info.distance {
            let remainingDistance = info.distance - distanceToLine
            sensorRanges.append(Range(min: info.sensor.x - remainingDistance, max: info.sensor.x + remainingDistance))
        }
    }

    return optimizeRanges(sensorRanges)
}

func getBeaconPosition() -> Position {
    for i in 0..<4000000 {
        let sensorRanges = getSensorRanges(y: i)

        if sensorRanges.count == 2 {
            return Position(x: sensorRanges[0].max + 1, y: i)
        }
    }
    assertionFailure("No beacon position found!")
    return Position(x: -1, y: -1)
}

// Part 1
let sensorRanges = getSensorRanges(y: 2000000)
let beaconPositions = Set(sensorInfo.filter{$0.beacon.y == 2000000}.map{$0.beacon.x})

var numBeaconsToSubtract = 0
for beaconPosition in beaconPositions {
    for sensorRange in sensorRanges {
        if sensorRange.contains(beaconPosition) {
            numBeaconsToSubtract += 1
            break
        }
    }
}

var answer1 = sensorRanges.map{$0.max - $0.min + 1}.reduce(0, +) - numBeaconsToSubtract
print(answer1)
assert(answer1 == 5525990, "Wrong answer! Expected 5525990")

// Part 2
let beaconPosition = getBeaconPosition()
assert(beaconPosition == Position(x: 2939043, y: 2628223), "Beacon position is incorrect!")

let answer2 = 4000000 * beaconPosition.x + beaconPosition.y
print(answer2)
assert(answer2 == 11756174628223, "Wrong answer! Expected 11756174628223")

let end = DispatchTime.now()
let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
let timeInterval = Double(nanoTime) / 1_000_000_000

print(timeInterval)


import Foundation

struct Position {
    var x: Int
    var y: Int
    var z: Int

    static func == (left: Position, right: Position) -> Bool {
        return left.x == right.x && left.y == right.y && left.z == right.z
    }

    func getAdjacentPositions() -> [Position] {
        return [Position(x: self.x + 1, y: self.y, z: self.z),
                Position(x: self.x - 1, y: self.y, z: self.z),
                Position(x: self.x, y: self.y + 1, z: self.z),
                Position(x: self.x, y: self.y - 1, z: self.z),
                Position(x: self.x, y: self.y, z: self.z + 1),
                Position(x: self.x, y: self.y, z: self.z - 1)]
    }

    func toString() -> String {
        return "\(self.x),\(self.y),\(self.z)"
    }
}

let coordinates = try! String(contentsOfFile: "input")
                        .split(separator: "\n")
                        .map{$0.split(separator: ",")}
                        .map{Position(x: Int($0[0])!, y: Int($0[1])!, z: Int($0[2])!)}

let coordinatesDict = coordinates.reduce(into: [String: Int]()) { $0[$1.toString()] = 0 }

var surfaceArea = 6 * coordinates.count

for coordinate in coordinates {
    for position in coordinate.getAdjacentPositions() {
        if coordinatesDict[position.toString()] != nil {
            surfaceArea -= 1
        }
    }
}

print(surfaceArea)
assert(surfaceArea == 4548, "Wrong answer! Expected 4548")

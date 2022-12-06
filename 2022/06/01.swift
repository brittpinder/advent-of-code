import Foundation

let data = try! String(contentsOfFile: "input")

func getUniquePacketIndex(packetSize: Int) -> Int {
    for index in 0..<(data.count - packetSize) {
        let first = data.index(data.startIndex, offsetBy: index)
        let last = data.index(data.startIndex, offsetBy: index + packetSize - 1)

        if Set(data[first...last]).count == packetSize {
            return index + packetSize
        }
    }
    return -1
}

let answer1 = getUniquePacketIndex(packetSize: 4)
print(answer1)
assert(answer1 == 1892, "Wrong answer! Expected 1892")

let answer2 = getUniquePacketIndex(packetSize: 14)
print(answer2)
assert(answer2 == 2313, "Wrong answer! Expected 2313")

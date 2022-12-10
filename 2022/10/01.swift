import Foundation

let commands = try! String(contentsOfFile: "input")
                    .replacingOccurrences(of: "\n", with: " ")
                    .split(separator: " ")
                    .map{String($0)}

let cycles = [20, 60, 100, 140, 180, 220]
var signalStrengthSums = 0
var value = 1

for cycle in 0..<commands.count {
    if let number = Int(commands[cycle]) {
        value += number
    }
    if cycles.contains(cycle + 1) {
        signalStrengthSums += (cycle + 1) * value
    }
}

print(signalStrengthSums)
assert(signalStrengthSums == 14240, "Wrong answer! Expected 14240")

import Foundation

let commands = try! String(contentsOfFile: "input")
    .replacingOccurrences(of: "\n", with: " ")
    .split(separator: " ")
    .map{String($0)}

var value = 1
var screen = Array(repeating: Array(repeating: ".", count: 40), count: 6)

for cycle in 0..<commands.count {
    let y = cycle / 40
    let x = cycle % 40

    if ((value - 1)...(value + 1)).contains(x) {
        screen[y][x] = "#"
    }
    if let number = Int(commands[cycle]) {
        value += number
    }
}

for line in screen {
    print(line.joined())
}

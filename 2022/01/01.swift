import Foundation

let contents = try! String(contentsOfFile: "input")

let elves = contents.split(separator: "\n\n")
                    .map{$0.split(separator: "\n").map{Int($0)!}}

var elfCalories = elves.map{$0.reduce(0, +)}
elfCalories.sort()

let numElves = elfCalories.count

let answer1 = elfCalories[numElves - 1]
print(answer1)
assert(answer1 == 66306, "Wrong answer! Expected 66306")

let answer2 = elfCalories[numElves - 3] + elfCalories[numElves - 2] + elfCalories[numElves - 1]
print(answer2)
assert(answer2 == 195292, "Wrong answer! Expected 195292")

import Foundation

struct Monkey {
    var items: [Int]
    var inspectionCount: Int = 0
    let operationFunction: (Int) -> Int
    let testDivisor: Int
    let trueResult: Int
    let falseResult: Int
}

func playGame(monkeys: inout [Monkey], numRounds: Int, reduceOperation: (Int) -> Int) -> Int {
    for _ in 0..<numRounds {
        for index in 0..<monkeys.count {
            let monkey = monkeys[index]
            while monkeys[index].items.count > 0 {
                monkeys[index].inspectionCount += 1

                var item = monkeys[index].items.removeFirst()
                item = monkey.operationFunction(item)
                item = reduceOperation(item)

                if item % monkey.testDivisor == 0 {
                    monkeys[monkey.trueResult].items.append(item)
                } else {
                    monkeys[monkey.falseResult].items.append(item)
                }
            }
        }
    }

    let sortedInspections = monkeys.map{$0.inspectionCount}.sorted()
    return sortedInspections[sortedInspections.count - 1] * sortedInspections[sortedInspections.count - 2]
}

func parseInput() -> [Monkey] {
    var monkeys = [Monkey]()
    let contents: [[Substring]] = try! String(contentsOfFile: "input")
                                        .split(separator: "\n\n")
                                        .map{$0.split(separator: "\n")}

    for monkeyInfo in contents {
        let items: [Int] = monkeyInfo[1].split(separator: ":")[1]
                                        .trimmingCharacters(in: .whitespaces)
                                        .split(separator: ", ")
                                        .map{Int($0)!}

        var operationFunction = {(x: Int) in x * x}

        let rightSide = monkeyInfo[2].split(separator: "= old ")[1].split(separator: " ")
        if rightSide[1] != "old" {
            if rightSide[0] == "*" {
                operationFunction = {(x: Int) in x * Int(rightSide[1])!}
            } else {
                operationFunction = {(x: Int) in x + Int(rightSide[1])!}
            }
        }

        let testDivisor: Int = Int(monkeyInfo[3].split(separator: "by ")[1])!
        let trueResult: Int = Int(monkeyInfo[4].split(separator: "monkey ")[1])!
        let falseResult: Int = Int(monkeyInfo[5].split(separator: "monkey ")[1])!

        monkeys.append(Monkey(items: items, operationFunction: operationFunction, testDivisor: testDivisor, trueResult: trueResult, falseResult: falseResult))
    }
    return monkeys
}

let originalMonkeys = parseInput()

var monkeys = originalMonkeys
let answer1 = playGame(monkeys: &monkeys, numRounds: 20, reduceOperation: {$0 / 3})
print(answer1)
assert(answer1 == 69918, "Wrong answer! Expected 69918")

monkeys = originalMonkeys
let magicNumber = originalMonkeys.map{$0.testDivisor}.reduce(1, *)
let answer2 = playGame(monkeys: &monkeys, numRounds: 10000, reduceOperation: {$0 % magicNumber})
print(answer2)
assert(answer2 == 19573408701, "Wrong answer! Expected 19573408701")

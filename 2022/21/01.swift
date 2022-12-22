import Foundation

enum Operation {
    case add, subtract, multiply, divide
}

func getOperationFromString(operation: String) -> Operation {
    switch operation {
        case "+": return Operation.add
        case "-": return Operation.subtract
        case "*": return Operation.multiply
        case "/": return Operation.divide
    default:
        assertionFailure("Unrecognized operation string: \(operation)")
        return Operation.add
    }
}

func getOppositeOperation(operation: Operation) -> Operation {
    switch operation {
        case Operation.add: return Operation.subtract
        case Operation.subtract: return Operation.add
        case Operation.multiply: return Operation.divide
        case Operation.divide: return Operation.multiply
    }
}

struct Monkey {
    var value: Int?
    var left: String?
    var right: String?
    var operation: Operation?

    init(value: Int) {
        self.value = value
    }

    init(left: String, right: String, operation: Operation) {
        self.left = left
        self.right = right
        self.operation = operation
    }
}

var input = try! String(contentsOfFile: "input")
                .split(separator: "\n")
                .map{$0.split(separator: ": ")}

var monkeys = [String : Monkey]()

for entry in input {
    if let value = Int(entry[1]) {
        monkeys[String(entry[0])] = Monkey(value: value)
    } else {
        let expression = entry[1].split(separator: " ")
        monkeys[String(entry[0])] = Monkey(left: String(expression[0]), right: String(expression[2]), operation: getOperationFromString(operation: String(expression[1])))
    }
}

func evaluateExpression(left: Int, right: Int, operation: Operation) -> Int {
    switch operation {
        case Operation.add: return left + right
        case Operation.subtract: return left - right
        case Operation.multiply: return left * right
        case Operation.divide: return left / right
    }
}

func evaluateMonkey1(name: String) -> Int {
    let monkey = monkeys[name]!
    if let value = monkey.value {
        return value
    }
    return evaluateExpression(left: evaluateMonkey1(name: monkey.left!),
                              right: evaluateMonkey1(name: monkey.right!),
                              operation: monkey.operation!)
}

func evaluateMonkey2(name: String) -> Int? {
    if name == "humn" {
        return nil
    }

    let monkey = monkeys[name]!
    if let value = monkey.value {
        return value
    }

    if let left = evaluateMonkey2(name: monkey.left!), let right = evaluateMonkey2(name: monkey.right!) {
        return evaluateExpression(left: left, right: right, operation: monkey.operation!)
    }
    return nil
}

let rootLeft: Int? = evaluateMonkey2(name: monkeys["root"]!.left!)
let rootRight: Int? = evaluateMonkey2(name: monkeys["root"]!.right!)

let knownValue: Int = rootLeft != nil ? rootLeft! : rootRight!
let unknownMonkeyName: String = rootLeft == nil ? monkeys["root"]!.left! : monkeys["root"]!.left!

func solveUnknownMonkey(name: String, value: Int) -> Int {
    if name == "humn" {
        return value
    }

    let monkey: Monkey = monkeys[name]!
    let leftSide: Int? = evaluateMonkey2(name: monkey.left!)
    let rightSide: Int? = evaluateMonkey2(name: monkey.right!)

    if leftSide == nil && rightSide != nil {
        let nextValue = evaluateExpression(left: value, right: rightSide!, operation: getOppositeOperation(operation: monkey.operation!))
        return solveUnknownMonkey(name: monkey.left!, value: nextValue)
    }
    if rightSide == nil && leftSide != nil {
        if monkey.operation! == Operation.add || monkey.operation! == Operation.multiply {
            let nextValue = evaluateExpression(left: value, right: leftSide!, operation: getOppositeOperation(operation: monkey.operation!))
            return solveUnknownMonkey(name: monkey.right!, value: nextValue)
        } else {
            let nextValue = evaluateExpression(left: leftSide!, right: value, operation: monkey.operation!)
            return solveUnknownMonkey(name: monkey.right!, value: nextValue)
        }
    }
    assertionFailure("No unknown side found!")
    return -1
}

let answer1 = evaluateMonkey1(name: "root")
print(answer1)
assert(answer1 == 80326079210554, "Wrong answer! Expected 80326079210554")

let answer2 = solveUnknownMonkey(name: unknownMonkeyName, value: knownValue)
print(answer2)
assert(answer2 == 3617613952378, "Wrong answer! Expected 3617613952378")

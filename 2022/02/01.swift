import Foundation

enum Shape {
    case rock, paper, scissors
}

enum Outcome {
    case win, loss, tie
}

func getScore(opponent: Shape, you: Shape) -> Int {
    let rockOutcome = [Shape.rock: Outcome.tie, Shape.paper: Outcome.loss, Shape.scissors: Outcome.win]
    let paperOutcome = [Shape.rock: Outcome.win, Shape.paper: Outcome.tie, Shape.scissors: Outcome.loss]
    let scissorsOutcome = [Shape.rock: Outcome.loss, Shape.paper: Outcome.win, Shape.scissors: Outcome.tie]

    let shapeScores = [Shape.rock: 1, Shape.paper: 2, Shape.scissors: 3]
    let outcomeScores = [Outcome.win: 6, Outcome.tie: 3, Outcome.loss: 0]

    var outcome: Outcome
    switch you {
    case Shape.rock: outcome = rockOutcome[opponent]!
    case Shape.paper: outcome = paperOutcome[opponent]!
    case Shape.scissors: outcome = scissorsOutcome[opponent]!
    }

    return shapeScores[you]! + outcomeScores[outcome]!
}

func getCorrectShapeForOutcome(opponent: Shape, outcome: Outcome) -> Shape {
    let winOutcome = [Shape.rock: Shape.paper, Shape.paper: Shape.scissors, Shape.scissors: Shape.rock]
    let tieOutcome = [Shape.rock: Shape.rock, Shape.paper: Shape.paper, Shape.scissors: Shape.scissors]
    let lossOutcome = [Shape.rock: Shape.scissors, Shape.paper: Shape.rock, Shape.scissors: Shape.paper]

    switch outcome {
    case Outcome.win: return winOutcome[opponent]!
    case Outcome.tie: return tieOutcome[opponent]!
    case Outcome.loss: return lossOutcome[opponent]!
    }
}

let contents = try! String(contentsOfFile: "input")

let rounds = contents.split(separator: "\n")
                     .map{$0.split(separator: " ").map{String($0)}}

let elfCodes = ["A": Shape.rock, "B": Shape.paper, "C": Shape.scissors]
let yourCodes = ["X": Shape.rock, "Y": Shape.paper, "Z": Shape.scissors]
let answer1 = rounds.map{getScore(opponent: elfCodes[$0[0]]!, you: yourCodes[$0[1]]!)}
                    .reduce(0, +)
print(answer1)
assert(answer1 == 15691, "Wrong answer! Expected 15691")

let outcomeCodes = ["X": Outcome.loss, "Y": Outcome.tie, "Z": Outcome.win]
let answer2 = rounds.map{(elfCodes[$0[0]]!, getCorrectShapeForOutcome(opponent: elfCodes[$0[0]]!, outcome: outcomeCodes[$0[1]]!))}
                    .map{getScore(opponent: $0.0, you: $0.1)}
                    .reduce(0, +)
print(answer2)
assert(answer2 == 12989, "Wrong answer! Expected 12989")

import Foundation

let start = DispatchTime.now()

enum Mineral: CaseIterable {
    case ore, clay, obsidian, geode
}

struct RobotCost {
    let mineral: Mineral
    let amount: Int
}

class Blueprint {
    let robotCosts: [Mineral : [RobotCost]]
    let maxMineralNeeded: [Mineral : Int]

    init(robotCosts: [Mineral : [RobotCost]]) {
        self.robotCosts = robotCosts

        var maxes = [Mineral.ore : 0, Mineral.clay : 0, Mineral.obsidian : 0, Mineral.geode : 0]
        for mineral in Mineral.allCases {
            for cost in robotCosts[mineral]! {
                if cost.amount > maxes[cost.mineral]! {
                    maxes[cost.mineral] = cost.amount
                }
            }
        }
        self.maxMineralNeeded = maxes
    }
}

class State {
    var minerals: [Mineral : Int]
    var robots: [Mineral : Int]
    var timeLeft: Int

    init(minerals: [Mineral : Int], robots: [Mineral : Int], timeLeft: Int) {
        self.minerals = minerals
        self.robots = robots
        self.timeLeft = timeLeft
    }

    init(other: State) {
        self.minerals = other.minerals
        self.robots = other.robots
        self.timeLeft = other.timeLeft
    }
}

let blueprintText = try! String(contentsOfFile: "input")
                            .split(separator: "\n")
                            .map{$0.split(separator: ".")
                                .map{$0.split(separator: " ")}
                            }

var blueprints = [Blueprint]()

for text in blueprintText {
    let robotCosts = [Mineral.ore: [RobotCost(mineral: Mineral.ore, amount: Int(text[0][6])!)],
                      Mineral.clay: [RobotCost(mineral: Mineral.ore, amount: Int(text[1][4])!)],
                      Mineral.obsidian: [RobotCost(mineral: Mineral.ore, amount: Int(text[2][4])!), RobotCost(mineral: Mineral.clay, amount: Int(text[2][7])!)],
                      Mineral.geode: [RobotCost(mineral: Mineral.ore, amount: Int(text[3][4])!), RobotCost(mineral: Mineral.obsidian, amount: Int(text[3][7])!)]]

    blueprints.append(Blueprint(robotCosts: robotCosts))
}

var currentBlueprint = blueprints[0]

func getElapsedTime() -> Double {
    let end = DispatchTime.now()
    let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
    let timeInterval = Double(nanoTime) / 1_000_000_000
    return timeInterval
}

func canMakeRobot(state: State, robotType: Mineral) -> Bool {
    for cost in currentBlueprint.robotCosts[robotType]! {
        if state.minerals[cost.mineral]! < cost.amount {
            return false
        }
    }
    return true
}

func hasAbilityToCreateRobot(state: State, robotType: Mineral) -> Bool {
    for cost in currentBlueprint.robotCosts[robotType]! {
        if state.robots[cost.mineral]! == 0 {
            return false
        }
    }
    return true
}

func getRobotsToAimFor(state: State) -> [Mineral] {
    var robotTypes = [Mineral]()

    for mineral in Mineral.allCases {
        if hasAbilityToCreateRobot(state: state, robotType: mineral) {
            if mineral == Mineral.geode {
                robotTypes.append(mineral)
            } else if state.timeLeft > 2 {
                if state.robots[mineral]! < currentBlueprint.maxMineralNeeded[mineral]! {
                    robotTypes.append(mineral)
                }
            }
        }
    }

    return robotTypes
}

func payForRobot(state: inout State, robotType: Mineral) {
    for cost in currentBlueprint.robotCosts[robotType]! {
        state.minerals[cost.mineral] = state.minerals[cost.mineral]! - cost.amount
    }
}

func waitToCreateRobot(state: inout State, robotType: Mineral) {
    while !canMakeRobot(state: state, robotType: robotType) && state.timeLeft > 0 {
        state.timeLeft -= 1
        for mineral in Mineral.allCases {
            state.minerals[mineral] = state.minerals[mineral]! + state.robots[mineral]!
        }
    }

    if state.timeLeft == 0 {
        return
    }

    state.timeLeft -= 1
    payForRobot(state: &state, robotType: robotType)
    for mineral in Mineral.allCases {
        state.minerals[mineral] = state.minerals[mineral]! + state.robots[mineral]!
    }
    state.robots[robotType] = state.robots[robotType]! + 1
}

func runOutTheClock(state: inout State) {
    for mineral in Mineral.allCases {
        state.minerals[mineral] = state.minerals[mineral]! + state.robots[mineral]! * state.timeLeft
    }
    state.timeLeft = 0
}

func chooseNextRobotsToBuild(state: inout State) -> [State] {
    var newStates = [State]()
    
    if state.timeLeft > 1 {
        for robotType in getRobotsToAimFor(state: state) {
            var newState = State(other: state)
            waitToCreateRobot(state: &newState, robotType: robotType)
            newStates.append(newState)
        }
    } else {
        runOutTheClock(state: &state)
        newStates.append(state)
    }

    return newStates
}

func getBestGeodeOutcomeWithTimeLeft(state: State) -> Int {
    if state.timeLeft == 0 {
        return state.minerals[Mineral.geode]!
    }
    return state.minerals[Mineral.geode]! + (state.robots[Mineral.geode]! * state.timeLeft) + (1..<state.timeLeft).reduce(0, +)
}

func getMaxGeodes(blueprint: Blueprint, time: Int) -> Int {
    currentBlueprint = blueprint
    var maxGeodesFoundSoFar = 0

    let startingMinerals = [Mineral.ore: 0, Mineral.clay: 0, Mineral.obsidian: 0, Mineral.geode: 0]
    let startingRobots = [Mineral.ore: 1, Mineral.clay: 0, Mineral.obsidian: 0, Mineral.geode: 0]
    let startingState = State(minerals: startingMinerals, robots: startingRobots, timeLeft: time)

    var states = [startingState]
    var finishedStates = [State]()

    while !states.isEmpty {
        var currentState = states.removeFirst()

        if currentState.timeLeft > 0 {
            for state in chooseNextRobotsToBuild(state: &currentState) {
                if getBestGeodeOutcomeWithTimeLeft(state: state) > maxGeodesFoundSoFar {
                    states.append(state)
                }
            }
        } else {
            finishedStates.append(currentState)
            let geodesFound = currentState.minerals[Mineral.geode]!
            if geodesFound > maxGeodesFoundSoFar {
                maxGeodesFoundSoFar = geodesFound
            }
        }
    }
    return maxGeodesFoundSoFar
}

var answer1 = 0
for index in 0..<blueprints.count {
    answer1 += (index + 1) * getMaxGeodes(blueprint: blueprints[index], time: 24)
}

print(answer1)
assert(answer1 == 1719, "Wrong answer! Expected 1719")
print(getElapsedTime())

var answer2 = 1
for index in 0..<3 {
    answer2 *= getMaxGeodes(blueprint: blueprints[index], time: 32)
}

print(answer2)
assert(answer2 == 19530, "Wrong answer! Expected 19530")
print(getElapsedTime())

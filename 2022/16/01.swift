import Foundation

struct ValveInfo {
    let name: String
    let rate: Int
    let connections: [String]
}

let contents = try! String(contentsOfFile: "input")
                    .split(separator: "\n")
                    .map{$0.split(separator: ";")}

var valveInformation = [String : ValveInfo]()

for line in contents {
    let name = String(line[0].split(separator: " ")[1])
    let rate = Int(line[0].split(separator: "=")[1])!
    var connections: [String]

    if line[1].contains("valves"){
        connections = line[1].split(separator: "valves ")[1].split(separator: ", ").map{String($0)}
    } else {
        connections = [String(line[1].split(separator: "valve ")[1])]
    }
    valveInformation[name] = ValveInfo(name: name, rate: rate, connections: connections)
}

let valvesWithPressure: [ValveInfo] = valveInformation.values.filter{$0.rate > 0}

func calculateValveDistances(for valve: ValveInfo) -> [String : Int] {
    var valveDistances = [String : Int]()

    var nextValves = valve.connections.map{(valve: valveInformation[$0]!, distance: 1)}
    var visitedValves = [valve.name] + valve.connections.map{$0}

    while nextValves.count > 0 {
        let nextValve = nextValves.removeFirst()

        valveDistances[nextValve.valve.name] = nextValve.distance

        for connection in nextValve.valve.connections {
            if !visitedValves.contains(connection) {
                nextValves.append((valve: valveInformation[connection]!, distance: nextValve.distance + 1))
                visitedValves.append(connection)
            }
        }
    }

    return valveDistances
}

var valveDistances = [String : [String : Int]]()
for valve in valveInformation.keys {
    let distances = calculateValveDistances(for: valveInformation[valve]!)
    valveDistances[valve] = distances
}

func getValveDistance(from: String, to: String) -> Int {
    if let valveDistanceInfo = valveDistances[from] {
        if let distance = valveDistanceInfo[to] {
            return distance
        }
    }
    assertionFailure("Valve not found!")
    return -1
}

func getMaximumPossiblePressure() -> Int {
    var maxPressure = 0
    //var maxPressurePath = [ValveInfo]() // Keeping this here just in case the actual path is ever needed

    func checkRemainingValves(currentValve: ValveInfo, visitedValves: [ValveInfo], remainingValves: [ValveInfo], totalDistance: Int, totalPressure: Int) {
        if remainingValves.count == 0 {
            if totalPressure > maxPressure {
                maxPressure = totalPressure
                //maxPressurePath = visitedValves
            }
        }

        for index in 0..<remainingValves.count {
            let valve = remainingValves[index]
            let distance = getValveDistance(from: currentValve.name, to: valve.name) + 1

            if totalDistance + distance > 30 {
                if totalPressure > maxPressure {
                    maxPressure = totalPressure
                    //maxPressurePath = visitedValves
                }
                continue
            }

            var visited = visitedValves.map{$0}
            visited.append(valve)

            var remaining = remainingValves.map{$0}
            remaining.remove(at: index)

            let pressure = (30 - totalDistance - distance) * valve.rate

            checkRemainingValves(currentValve: valve, visitedValves: visited, remainingValves: remaining, totalDistance: totalDistance + distance, totalPressure: totalPressure + pressure)
        }
    }

    checkRemainingValves(currentValve: valveInformation["AA"]!, visitedValves: [ValveInfo](), remainingValves: valvesWithPressure, totalDistance: 0, totalPressure: 0)

    return maxPressure
}

let answer = getMaximumPossiblePressure()
print(answer)
assert(answer == 1641, "Wrong answer! Expected 1641")

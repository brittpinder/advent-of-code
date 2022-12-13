import Foundation

struct Position {
    let x: Int
    let y: Int
}

class Node {
    let char: Character
    let charValue: Int
    let position: Position
    var distance: Int?
    var visited: Bool

    init(char: Character, charValue: Int,position: Position) {
        self.char = char
        self.charValue = charValue
        self.position = position
        self.visited = false
    }
}

func getCharValue(char: Character) -> Int {
    return Int(char.unicodeScalars.first!.value)
}

func getUnvisitedNeighbours(nodes: [[Node]], position: Position, canMove: (Int, Int) -> Bool) -> [Node] {
    let currentCharValue = nodes[position.y][position.x].charValue
    var neighbours = [Node]()

    func checkNeighbour(at pos: Position) {
        if pos.x >= 0 && pos.x < nodes[0].count && pos.y >= 0 && pos.y < nodes.count {
            let node = nodes[pos.y][pos.x]
            if !node.visited && canMove(currentCharValue, node.charValue) {
                neighbours.append(node)
            }
        }
    }

    checkNeighbour(at: Position(x: position.x, y: position.y - 1))
    checkNeighbour(at: Position(x: position.x, y: position.y + 1))
    checkNeighbour(at: Position(x: position.x - 1, y: position.y))
    checkNeighbour(at: Position(x: position.x + 1, y: position.y))

    return neighbours
}

func findEndNode(characters: [[Character]], startChar: Character, endChar: Character, canMove: (Int, Int) -> Bool) -> Node? {
    let width = characters[0].count
    let height = characters.count

    // Create nodes
    var nodes = Array(repeating: [Node](), count: height)
    for y in 0..<height {
        for x in 0..<width {
            var char = characters[y][x]
            if char == "S" {
                char = "a"
            } else if char == "E" {
                char = "z"
            }
            nodes[y].append(Node(char: characters[y][x], charValue: getCharValue(char: char), position: Position(x: x, y: y)))
        }
    }

    // Find the starting node
    guard let startNode = nodes.flatMap({$0}).first(where: {$0.char == startChar}) else {
        assertionFailure("Unable to find starting node!")
        return nil
    }

    // Run dijkstra's algorithm
    var currentNode = startNode
    currentNode.visited = true
    currentNode.distance = 0

    while currentNode.char != endChar {
        let neighbours = getUnvisitedNeighbours(nodes: nodes, position: currentNode.position, canMove: canMove)

        // Update distance estimates
        let pathLength = currentNode.distance! + 1
        for neighbour in neighbours {
            if neighbour.distance == nil || pathLength < neighbour.distance! {
                neighbour.distance = pathLength
            }
        }

        // Choose next node (the unvisited node with the smallest distance)
        currentNode = nodes.flatMap{$0}
                           .filter{!$0.visited && $0.distance != nil}
                           .sorted{$0.distance! < $1.distance!}[0]
        currentNode.visited = true
    }
    return currentNode
}

let elevations = try! String(contentsOfFile: "input").split(separator: "\n").map{Array($0)}

let answer1 = findEndNode(characters: elevations, startChar: "S", endChar: "E", canMove: {$0 - $1 >= -1})!.distance!
print(answer1)
assert(answer1 == 420, "Wrong answer! Expected 420")

let answer2 = findEndNode(characters: elevations, startChar: "E", endChar: "a", canMove: {$0 - $1 <= 1})!.distance!
print(answer2)
assert(answer2 == 414, "Wrong answer! Expected 414")

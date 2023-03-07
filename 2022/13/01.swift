import Foundation

enum Order {
    case right, wrong, unknown
}

class Node {
    var value: Int?
    unowned var parent: Node?
    var children = [Node]()

    init(parent: Node?) {
        self.value = nil
        self.parent = parent
    }

    init(parent: Node, value: Int) {
        self.value = value
        self.parent = parent
    }

    func addChild(_ child: Node) {
        children.append(child)
    }

    func inOrder(other: Node) -> Order {
        // Handle no children
        if children.count == 0 && other.children.count == 0 {
            return Order.unknown
        } else if children.count == 0 {
            return Order.right
        } else if other.children.count == 0 {
            return Order.wrong
        }

        var childIndex = -1
        while true {
            childIndex += 1

            // Handle either running out of children
            if childIndex == children.count {
                return Order.right
            } else if childIndex == other.children.count {
                return Order.wrong
            }

            let child = children[childIndex]
            let otherChild = other.children[childIndex]

            if child.value != nil && otherChild.value != nil { // Handle both children being numbers
                if child.value! > otherChild.value! {
                    return Order.wrong
                } else if child.value! < otherChild.value! {
                    return Order.right
                }
            } else if child.value == nil && otherChild.value == nil { // Handle both children being arrays
                let result = child.inOrder(other: otherChild)
                if result != Order.unknown {
                    return result
                }
            } else { // Handle mixed types
                if child.value != nil {
                    child.addChild(Node(parent: child, value: child.value!))
                    child.value = nil
                } else {
                    otherChild.addChild(Node(parent: otherChild, value: otherChild.value!))
                    otherChild.value = nil
                }
                let result = child.inOrder(other: otherChild)
                if result != Order.unknown {
                    return result
                }
            }
        }
    }
}

struct Packet {
    var text: String
    var tree: Node

    init(text: String) {
        self.text = text
        self.tree = createTree(input: text)
    }
}

func createTree(input: String) -> Node {
    var text = input
    let root = Node(parent: nil)
    var currentNode = root

    while text.count > 0 {
        let char = text.removeFirst()
        if let number = Int(String(char)) {
            let index = text.firstIndex(where: {Int(String($0)) == nil})!
            let restOfNumber = text[..<index]
            let fullNumber = Int(String(number) + String(restOfNumber))!
            text.removeSubrange(text.startIndex..<index)
            currentNode.addChild(Node(parent: currentNode, value: fullNumber))
        } else if char == "[" {
            let child = Node(parent: currentNode)
            currentNode.addChild(child)
            currentNode = child
        } else if char == "]" {
            currentNode = currentNode.parent!
        }
    }
    return root.children[0]
}

func isPacketPairInOrder(left: Node, right: Node) -> Bool {
    return left.inOrder(other: right) == Order.right
}

let textPairs: [[String]] = try! String(contentsOfFile: "input")
                                    .split(separator: "\n\n")
                                    .map{$0.split(separator: "\n")
                                        .map{String($0)}
                                    }

let packetPairs: [[Packet]] = textPairs.map{$0.map{Packet(text: $0)}}

let answer1 = packetPairs.enumerated()
                         .map { (index, pair) in
                             return isPacketPairInOrder(left: pair[0].tree, right: pair[1].tree) ? index + 1 : 0
                         }
                         .reduce(0, +)

print(answer1)
assert(answer1 == 6369, "Wrong answer! Expected 6369")


var extraPacketText1 = "[[2]]"
var extraPacketText2 = "[[6]]"

var allPackets: [Packet] = packetPairs.flatMap{$0}
allPackets.append(Packet(text: extraPacketText1))
allPackets.append(Packet(text: extraPacketText2))

let sortedPackets: [Packet] = allPackets.sorted{isPacketPairInOrder(left: $0.tree, right: $1.tree)}

var index1 = sortedPackets.firstIndex(where: {$0.text == extraPacketText1})
var index2 = sortedPackets.firstIndex(where: {$0.text == extraPacketText2})

let index1Int: Int = sortedPackets.distance(from: sortedPackets.startIndex, to: index1!) + 1
let index2Int: Int = sortedPackets.distance(from: sortedPackets.startIndex, to: index2!) + 1

let answer2 = index1Int * index2Int
print(answer2)
assert(answer2 == 25800, "Wrong answer! Expected 25800")

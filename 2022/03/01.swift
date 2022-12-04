import Foundation

func getCommonCharacters(_ strings: [String]) -> [Character] {
    if strings.isEmpty {
        return [Character]()
    }

    var commonCharacters = Set(strings[0])
    for index in 1..<strings.count {
        commonCharacters = commonCharacters.intersection(strings[index])
    }

    return Array(commonCharacters)
}

func getPriorityForCharacter(_ char: Character) -> UInt32 {
    if !char.isLetter {
        assertionFailure("Error: Non-letter character encountered: \(char)")
    }

    let charValue = char.unicodeScalars.first!.value
    return char.isLowercase ? charValue - 96 : charValue - 38
}

func getPriorityOfCommonCharacter(_ strings: [String]) -> UInt32 {
    let commonCharacters = getCommonCharacters(strings)
    if commonCharacters.count != 1 {
        assertionFailure("Error: There should only be one common letter!")
    }

    return getPriorityForCharacter(commonCharacters[0])
}

let contents = try! String(contentsOfFile: "input")

let rucksacks: [String] = contents.split(separator: "\n")
                                  .map{String($0)}

let compartments: [[String]] = rucksacks.map{[String($0.prefix($0.count/2)), String($0.suffix($0.count/2))]}

let answer1 = compartments.map{getPriorityOfCommonCharacter($0)}
                          .reduce(0, +)
print(answer1)
assert(answer1 == 7793, "Wrong answer! Expected 7793")

var elfGroups = [[String]]()
var group = [String]()
for index in 0..<rucksacks.count {
    group.append(rucksacks[index])
    if (index + 1) % 3 == 0 {
        elfGroups.append(group)
        group.removeAll()
    }
}

let answer2 = elfGroups.map{getPriorityOfCommonCharacter($0)}
                       .reduce(0, +)
print(answer2)
assert(answer2 == 2499, "Wrong answer! Expected 2499")

import Foundation

struct PasswordInfo {
    let min: Int
    let max: Int
    let letter: Character
    let password: String
}

func isValidPart1(info: PasswordInfo) -> Bool {
    let occurrences = info.password.filter{$0 == info.letter}.count
    return (info.min...info.max).contains(occurrences)
}

func isValidPart2(info: PasswordInfo) -> Bool {
    let password = info.password
    let pos1 = password[password.index(password.startIndex, offsetBy: info.min-1)] == info.letter ? 1 : 0
    let pos2 = password[password.index(password.startIndex, offsetBy: info.max-1)] == info.letter ? 1 : 0
    return pos1 + pos2 == 1
}

let contents = try! String(contentsOfFile: "Input")
let lines = contents.split(separator: "\n")
    .map({
        let elements = $0.split(separator: " ")
        
        let range = elements[0].split(separator: "-")
        let min = Int(String(range[0]))!
        let max = Int(String(range[1]))!
        
        let letter = elements[1][elements[1].startIndex]
        let password = String(elements[2])
        
        return PasswordInfo(min: min, max: max, letter: letter, password: password)
    })

let answer1 = lines.filter(isValidPart1).count
print(answer1)
assert(answer1 == 660, "Wrong answer! Expected 660")

let answer2 = lines.filter(isValidPart2).count
print(answer2)
assert(answer2 == 530, "Wrong answer! Expected 530")

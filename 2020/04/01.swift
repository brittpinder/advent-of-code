import Foundation

func hasRequiredFields(_ passport: [String: String]) -> Bool {
    let requiredFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    for field in requiredFields {
        if passport[field] == nil {
            return false
        }
    }
    return true
}

func hasValidBirthYear(_ passport: [String: String]) -> Bool {
    if passport["byr"] == nil {
        return false
    }
    if let birthYear = Int(passport["byr"]!) {
        if (1920...2002).contains(birthYear) {
            return true
        }
    }
    return false
}

func hasValidIssueYear(_ passport: [String: String]) -> Bool {
    if passport["iyr"] == nil {
        return false
    }
    if let issueYear = Int(passport["iyr"]!) {
        if (2010...2020).contains(issueYear) {
            return true
        }
    }
    return false
}

func hasValidExpirationYear(_ passport: [String: String]) -> Bool {
    if passport["eyr"] == nil {
        return false
    }
    if let expirationYear = Int(passport["eyr"]!) {
        if (2020...2030).contains(expirationYear) {
            return true
        }
    }
    return false
}

func hasValidHeight(_ passport: [String: String]) -> Bool {
    if let height = passport["hgt"] {
        if height.hasSuffix("in") {
            if let value = Int(height.replacingOccurrences(of: "in", with: "")) {
                if (59...76).contains(value) {
                    return true
                }
            }
        } else if height.hasSuffix("cm") {
            if let value = Int(height.replacingOccurrences(of: "cm", with: "")) {
                if (150...193).contains(value) {
                    return true
                }
            }
        }
    }
    return false
}

func hasValidHairColor(_ passport: [String: String]) -> Bool {
    if let hairColor = passport["hcl"] {
        if !hairColor.hasPrefix("#") || hairColor.count != 7 {
            return false
        }
        for i in 1...6 {
            let char = String(hairColor[hairColor.index(hairColor.startIndex, offsetBy: i)])
            if Int(char) != nil || ["a", "b", "c", "d", "e", "f"].contains(char) {
                return true
            }
        }
    }
    return false
}

func hasValidEyeColor(_ passport: [String: String]) -> Bool {
    if let eyeColor = passport["ecl"] {
        if ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(eyeColor) {
            return true
        }
    }
    return false
}

func hasValidPassportID(_ passport: [String: String]) -> Bool {
    if let passportID = passport["pid"] {
        if passportID.count == 9 && Int(passportID) != nil {
            return true
        }
    }
    return false
}

func isPassportValid(_ passport: [String: String]) -> Bool {
    let validations = [hasValidBirthYear, hasValidIssueYear, hasValidExpirationYear, hasValidHeight, hasValidHairColor, hasValidEyeColor, hasValidPassportID]

    for validation in validations {
        if !validation(passport) {
            return false
        }
    }
    return true
}

let contents = try! String(contentsOfFile: "input")

let groups = contents.split(separator: "\n\n")
    .map{$0.replacingOccurrences(of: "\n", with: " ")}
    .map{$0.split(separator: " ")}

var passports: [[String: String]] = [[:]]

for group in groups {
    var passport: [String: String] = [:]
    for field in group {
        let info = field.split(separator: ":")
        passport[String(info[0])] = String(info[1])
    }
    passports.append(passport)
}

var answer1 = passports.filter({hasRequiredFields($0)}).count
print(answer1)
assert(answer1 == 182, "Wrong answer! Expected 182")

var answer2 = passports.filter({isPassportValid($0)}).count
print(answer2)
assert(answer2 == 109, "Wrong answer! Expected 109")

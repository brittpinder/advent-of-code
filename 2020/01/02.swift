import Foundation

func calculateAnswer(_ numbers: [Int]) -> Int {
    let totalNumbers = numbers.count
    
    for i in 0..<totalNumbers {
        let num1 = numbers[i]
        
        for j in i+1..<totalNumbers {
            let num2 = numbers[j]
            if num1 + num2 > 2020 {
                continue
            }
            
            for k in j+1..<totalNumbers {
                let num3 = numbers[k]
                if num1 + num2 + num3 == 2020 {
                    return num1 * num2 * num3
                }
            }
        }
    }
    return -1
}

let contents = try! String(contentsOfFile: "Input")
let numbers = contents.split(separator: "\n")
                      .compactMap{Int($0)}
let answer = calculateAnswer(numbers)

print(answer)
assert(answer == 73616634, "Answer is incorrect!")

let fs = require('fs');

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
let instructions = fileData.split("\n")
                             .map(x => x.split(" "))
                             .map(x => {
                                return {
                                    type: x[0],
                                    num: +x[1],
                                    visited: false
                                }
                             });

let acc = 0;
let lineIndex = 0;

while (lineIndex < instructions.length) {
    let instruction = instructions[lineIndex];
    if (instruction.visited) {
        break;
    }
    instruction.visited = true;
    if (instruction.type === "nop") {
        lineIndex++;
    } else if (instruction.type === "acc") {
        acc += instruction.num;
        lineIndex++;
    } else if (instruction.type === "jmp") {
        lineIndex += instruction.num;
    }
}

console.log("accumulator: " + acc);
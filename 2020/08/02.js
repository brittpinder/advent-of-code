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

const getAccumulator = (instructions) => {
    for (let instruction of instructions) {
        instruction.visited = false;
    }
    let lineIndex = 0;
    let acc = 0;
    while (lineIndex < instructions.length) {
        let instruction = instructions[lineIndex];
        if (instruction.visited) {
            return {
                acc: acc,
                isInfiniteLoop: true
            };
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
    return {
        acc: acc,
        isInfiniteLoop: false
    };
}

const fixProgramAndGetAccumulator = () => {
    for (let instruction of instructions) {
        if (instruction.type === "jmp" || instruction.type === "nop") {
            const backupType = instruction.type;
            instruction.type = instruction.type === "jmp" ? "nop" : "jmp";
            const result = getAccumulator(instructions);
            if (result.isInfiniteLoop) {
                instruction.type = backupType;
            } else {
                return result.acc;
            }
        }
    }
    return -1;
}

console.log("accumulator: " + fixProgramAndGetAccumulator());
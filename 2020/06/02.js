let fs = require('fs');

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
const groups = fileData.split("\n\n")
                       .map(x => x.split("\n"));

let sum = 0;

for (const group of groups) {
    const firstPerson = group[0];
    for (let i = 0; i < firstPerson.length; ++i) {
        const char = firstPerson.charAt(i);
        let allContainChar = true;
        for (let j = 1; j < group.length; ++j) {
            if (!group[j].includes(char)) {
                allContainChar = false;
                break;
            }
        }
        sum += allContainChar ? 1 : 0;
    }
}

console.log("Sum: " + sum);
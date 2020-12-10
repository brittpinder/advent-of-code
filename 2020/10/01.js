let fs = require('fs');

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
let adapters = fileData.split("\n")
                       .map(x => +x)
                       .sort((a, b) => a - b);

adapters.unshift(0);
adapters.push(adapters[adapters.length - 1] + 3);

let total1 = 0;
let total3 = 0;
for (let i = 0; i < adapters.length - 1; ++i) {
    const diff = adapters[i + 1] - adapters[i];
    if (diff === 1) {
        total1++;
    } else if (diff === 3) {
        total3++;
    }
}

console.log("Answer: " + (total1 * total3));

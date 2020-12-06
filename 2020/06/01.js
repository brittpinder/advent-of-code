let fs = require('fs');

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
const sum = fileData.split("\n\n")
                    .map(x => x.replace(/\n/g, ""))
                    .map(x => x.split(""))
                    .map(x => new Set(x))
                    .map(x => x.size)
                    .reduce((accumulator, x) => x + accumulator);

console.log("Sum: " + sum);
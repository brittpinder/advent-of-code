let fs = require('fs');

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
const lines = fileData.split("\n");

let numTrees = 0;
let horizontalIndex = 0;
const rowLength = lines[0].length;

for (let i = 1; i < lines.length; ++i) {
    horizontalIndex = (horizontalIndex + 3) % rowLength;

    if (lines[i].charAt(horizontalIndex) === "#") {
        numTrees++;
    }
}

console.log("Number of trees: " + numTrees);

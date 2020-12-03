let fs = require('fs');

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
const lines = fileData.split("\n");
const rowLength = lines[0].length;

const getNumTreesOnSlope = (x, y) => {
    let numTrees = 0;
    let horizontalIndex = 0;

    for (let i = y; i < lines.length; i += y) {
        horizontalIndex = (horizontalIndex + x) % rowLength;

        if (lines[i].charAt(horizontalIndex) === "#") {
            numTrees++;
        }
    }
    return numTrees;
}

const slopes = [
    [1,1],
    [3,1],
    [5,1],
    [7,1],
    [1,2]
]

const totalTrees = slopes.map(x => getNumTreesOnSlope(x[0], x[1]))
                         .reduce((accumulator, x) => accumulator * x);

console.log("Number of trees: " + totalTrees);

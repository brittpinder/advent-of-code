let fs = require('fs');

// Part 1
const arrayContainsPairWithSum = (array, sum) => {
    let visited = new Set();
    for (const number of array) {
        if (visited.has(sum - number)) {
            return true;
        }
        visited.add(number);
    }
    return false;
}

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
const numbers = fileData.split("\n").map(x => +x);

let target = -1;
for (let i = 25; i < numbers.length; ++i) {
    if (!arrayContainsPairWithSum(numbers.slice(i - 25, i), numbers[i])) {
        target = numbers[i];
        break;
    }
}

console.log("Answer Part 1: " + target);

// Part 2
let start = 0;
let end = 0;
let sum = numbers[0];

while (start < numbers.length) {
    if (sum < target) {
        end++;
        sum += numbers[end];
    } else if (sum > target) {
        sum -= numbers[start];
        start++;
    } else if (sum === target) {
        break;
    }
}

const range = numbers.slice(start, end + 1);
const min = Math.min(...range);
const max = Math.max(...range);

console.log("Answer Part 2: " + (min + max));

var fs = require('fs');
var data = [];

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'}); 
const lines = fileData.split("\n");
for (const line of lines) {
    data.push(+line);
}

let visited = new Set();
for (var i = 0; i < data.length; ++i) {
    const num = data[i];
    if (num > 2020) {
        continue;
    }

    const target = 2020 - num;
    if (visited.has(target)) {
        console.log(num * target);
    }
    visited.add(num);
}

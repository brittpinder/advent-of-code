var fs = require('fs');
var data = [];

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'}); 
const lines = fileData.split("\n");
for (const line of lines) {
    data.push(+line);
}

for (var i = 0; i < data.length; ++i) {
    const num1 = data[i];
    for (var j = i + 1; j < data.length; ++j) {
        const num2 = data[j];
        for (var k = j + 1; k < data.length; ++k) {
            const num3 = data[k];
            if (num1 + num2 + num3 === 2020) {
                console.log(num1 * num2 * num3);
            }
        }
    }
}
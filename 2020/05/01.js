let fs = require('fs');

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
const lines = fileData.split("\n");

let maxSeatId = 0;

for (let line of lines) {
    const rowBinary = line.substr(0, 7).replace(/B/g, '1').replace(/F/g, '0');
    const columnBinary = line.substr(7, 3).replace(/R/g, '1').replace(/L/g, '0');

    const row = parseInt(rowBinary, 2);
    const column = parseInt(columnBinary, 2);

    const seatId = row * 8 + column;
    maxSeatId = Math.max(maxSeatId, seatId);
}

console.log("Max Seat Id: " + maxSeatId);
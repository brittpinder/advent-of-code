let fs = require('fs');

const getSeatId = (code) => {
    const rowBinary = code.substr(0, 7).replace(/B/g, '1').replace(/F/g, '0');
    const columnBinary = code.substr(7, 3).replace(/R/g, '1').replace(/L/g, '0');

    const row = parseInt(rowBinary, 2);
    const column = parseInt(columnBinary, 2);

    return row * 8 + column;
}

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
const lines = fileData.split("\n");
const sortedSeatIds = lines.map(line => getSeatId(line))
                           .sort((a, b) => a - b);

for (let i = 0; i < sortedSeatIds.length - 1; ++i) {
    if (sortedSeatIds[i + 1] !== sortedSeatIds[i] + 1) {
        console.log("My Seat Id: " + (sortedSeatIds[i] + 1));
        break;
    }
}

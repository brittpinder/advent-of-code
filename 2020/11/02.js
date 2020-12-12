let fs = require('fs');

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
let seats = fileData.split("\n")
                    .map(x => x.split(""));

for (let i = 0; i < seats.length; ++i) {
    seats[i] = seats[i].map(x => {
        return {
            value: x,
            dirty: false
        }
    });
}

const width = seats[0].length;
const height = seats.length;

const directions = [
    [-1, -1], // top left
    [0, -1], // top
    [1, -1], // top right
    [1, 0], // right
    [1, 1], // bottom right
    [0, 1], // bottom
    [-1, 1], // bottom left
    [-1, 0] // left
];

const isSeatVisiblyOccupied = (x, y, direction) => {
    x += direction[0];
    y += direction[1];

    while (x >= 0 && x < width && y >= 0 && y < height) {
        const seatValue = seats[y][x].value;
        if (seatValue === "#") {
            return true;
        } else if (seatValue === "L") {
            return false;
        }
        x += direction[0];
        y += direction[1];
    }
    return false;
}

const getNumVisiblyOccupiedSeats = (x, y) => {
    let num = 0;
    for (const direction of directions) {
        if (isSeatVisiblyOccupied(x, y, direction)) {
            num++;
        }
    }
    return num;
}

let markSeatsThatShouldChange = () => {
    for (let x = 0; x < width; ++x) {
        for (let y = 0; y < height; ++y) {
            const numOccupied = getNumVisiblyOccupiedSeats(x, y);
            let seat = seats[y][x];
            if (seat.value === "L" && numOccupied === 0) {
                seat.dirty = true;
            } else if (seat.value === "#" && numOccupied >= 5) {
                seat.dirty = true;
            }
        }
    }
}

let changeSeats = () => {
    let changeMade = false;
    for (let x = 0; x < width; ++x) {
        for (let y = 0; y < height; ++y) {
            let seat = seats[y][x];
            if (seat.dirty) {
                if (seat.value === "#") {
                    seat.value = "L";
                } else if (seat.value === "L") {
                    seat.value = "#";
                }
                seat.dirty = false;
                changeMade = true;
            }
        }
    }
    return changeMade;
}

while (true) {
    markSeatsThatShouldChange();
    const changeMade = changeSeats();
    if (!changeMade) {
        break;
    }
}

let numOccupiedSeats = 0;
for (let x = 0; x < width; ++x) {
    for (let y = 0; y < height; ++y) {
        if (seats[y][x].value === "#") {
            numOccupiedSeats++;
        }
    }
}

console.log("Number of occupied seats: " + numOccupiedSeats);

let fs = require('fs');

const rotateDirectionLeft90 = (direction) => {
    return { x: direction.y, y: -direction.x };
}

const rotateDirectionRight90 = (direction) => {
    return { x: -direction.y, y: direction.x };
}

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
let instructions = fileData.split("\n")
                           .map(x => {
                               return {
                                   action: x.substr(0, 1),
                                   value: +x.substr(1, x.length - 1)
                               }
                           });

let currentPosition = { x: 0, y: 0 };
let facingDirection = { x: 1, y: 0 };

for (const instruction of instructions) {
    const action = instruction.action;
    const value = instruction.value;
    if (action === "N") {
        currentPosition.y -= value;
    } else if (action === "E") {
        currentPosition.x += value;
    } else if (action === "S") {
        currentPosition.y += value;
    } else if (action === "W") {
        currentPosition.x -= value;
    } else if (action === "F") {
        currentPosition.x += facingDirection.x * value;
        currentPosition.y += facingDirection.y * value;
    } else if (action === "R") {
        const numRotations = value / 90;
        for (let i = 0; i < numRotations; ++i) {
            facingDirection = rotateDirectionRight90(facingDirection);
        }
    } else if (action === "L") {
        const numRotations = value / 90;
        for (let i = 0; i < numRotations; ++i) {
            facingDirection = rotateDirectionLeft90(facingDirection);
        }
    }
}

console.log("Manhattan Distance: " + (Math.abs(currentPosition.x) + Math.abs(currentPosition.y)));

let fs = require('fs');

const decimalToBinary = (decimal) => {
    return (decimal >>> 0).toString(2).padStart(36, '0');
}

const binaryToDecimal = (binary) => {
    return parseInt(binary, 2).toString(10);
}

const applyBitmask = (value, mask) => {
    if (value.length != mask.length) {
        throw('value and mask must have the same length!');
    }
    value = value.split('');
    for (let i = 0; i < value.length; ++i) {
        const char = mask.charAt(i);
        if (char !== '0') {
            value[i] = char;
        }
    }
    return value.join('');
}

const getAllPossibleValues = (values) => {
    let possibleValues = [];
    while (values.length > 0) {
        const value = values.shift();
        const index = value.indexOf('X');
        if (index > -1) {
            values.push(value.slice(0, index) + "0" + value.slice(index + 1));
            values.push(value.slice(0, index) + "1" + value.slice(index + 1));
        } else {
            possibleValues.push(value);
        }
    }
    return possibleValues;
}

// Alternate algorithm using recursion
const getAllPossibleValuesRecursive = (values) => {
    let newValues = [];
    let foundX = false;
    for (const value of values) {
        const index = value.indexOf('X');
        if (index > -1) {
            newValues.push(value.slice(0, index) + "0" + value.slice(index + 1));
            newValues.push(value.slice(0, index) + "1" + value.slice(index + 1));
            foundX = true;
        }
    }
    return foundX ? getAllPossibleValuesRecursive(newValues) : values;
}

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
let lines = fileData.split('\n');

let mask = decimalToBinary(0);
let memory = new Map();

for (const line of lines) {
    if (line.startsWith('mask')) {
        mask = line.split(' = ')[1];
    } else if (line.startsWith('mem')) {
        let [address, value] = line.split(' = ');
        address = Number(address.substring(4, address.length - 1));

        const binaryAddress = decimalToBinary(address);
        const maskedAddress = applyBitmask(binaryAddress, mask);
        const allAddresses = getAllPossibleValues([maskedAddress]).map(x => binaryToDecimal(x));

        for (const address of allAddresses) {
            memory[address] = Number(value);
        }
    }
}

const sum = Object.values(memory).reduce((accumulator, x) => accumulator + x);

console.log(sum);

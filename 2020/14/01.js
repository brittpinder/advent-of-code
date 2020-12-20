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
        if (char !== 'X') {
            value[i] = char;
        }
    }
    return value.join('');
}

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
let lines = fileData.split('\n');

let mask = decimalToBinary(0);
let memory = {};

for (const line of lines) {
    if (line.startsWith('mask')) {
        mask = line.split(' = ')[1];
    } else if (line.startsWith('mem')) {
        let [address, value] = line.split(' = ');
        address = address.substring(4, address.length - 1);

        value = decimalToBinary(value);
        value = applyBitmask(value, mask);
        value = binaryToDecimal(value);

        memory[address] = Number(value);
    }
}

const sum = Object.values(memory).reduce((accumulator, x) => accumulator + x);

console.log(sum);

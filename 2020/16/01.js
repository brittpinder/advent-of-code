let fs = require('fs');

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
let [fields, tickets] = fileData.split('your ticket:').map(x => x.trim());

fields = fields.split('\n');

let allRanges = [];
for (const field of fields) {
    const ranges = field.split(':')
                      .map(x => x.trim())
                      [1]
                      .split('or')
                      .map(x => x.trim());

    for (const range of ranges) {
        const [min, max] = range.split('-')
                                .map(x => Number(x));
        allRanges.push({
            min: min,
            max: max
        });
    }
}

const isNumberValidForAnyField = (num) => {
    for (const range of allRanges) {
        if (num >= range.min && num <= range.max) {
            return true;
        }
    }
    return false;
}

const ticketScanningErrorRate = tickets.split('nearby tickets:')
                                       [1]
                                       .split(/[\n,]/)
                                       .map(x => Number(x))
                                       .filter(x => !isNumberValidForAnyField(x))
                                       .reduce((accumulator, x) => accumulator + x, 0);

console.log(ticketScanningErrorRate);

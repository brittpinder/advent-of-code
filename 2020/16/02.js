let fs = require('fs');

const isNumberInFieldRange = (field, number) => {
    for (const range of field.ranges) {
        if (number >= range.min && number <= range.max) {
            return true;
        }
    }
    return false;
}

const isNumberValidForAnyField = number => {
    for (const field of fields) {
        if (isNumberInFieldRange(field, number)) {
            return true;
        }
    }
    return false;
}

const isTicketValid = ticket => {
    for (const value of ticket) {
        if (!isNumberValidForAnyField(value)) {
            return false;
        }
    }
    return true;
}

const getTicketValuesPerIndex = tickets => {
    let indeces = new Map();
    for (let i = 0; i < tickets[0].length; ++i) {
        indeces.set(i, []);
    }
    for (const ticket of tickets) {
        ticket.forEach(function(value, index) {
            let currentArray = indeces.get(index);
            currentArray.push(ticket[index]);
            indeces.set(index, currentArray);
        });
    }
    return indeces;
}

const getAllPossibleIndecesPerField = ticketValuesPerIndex => {
    let fieldsWithPossibleIndeces = [];
    fields.forEach(field => {
        let possibleIndeces = [];
        for (const [index, ticketValues] of ticketValuesPerIndex) {
            if (!ticketValues.find(value => !isNumberInFieldRange(field, value))) {
                possibleIndeces.push(index);
            }
        }
        fieldsWithPossibleIndeces.push({
            name: field.name,
            possibleIndeces: possibleIndeces,
            foundIndex: false
        });
    });
    return fieldsWithPossibleIndeces;
}

const findAndRemoveSingleIndeces = fields => {
    for (let field of fields) {
        if (field.foundIndex || field.possibleIndeces.length != 1) {
            continue;
        }
        field.foundIndex = true;
        const valueToRemove = field.possibleIndeces[0];
        for (let fieldToRemoveFrom of fields) {
            if (fieldToRemoveFrom !== field && fieldToRemoveFrom.possibleIndeces.includes(valueToRemove)) {
                const position = fieldToRemoveFrom.possibleIndeces.indexOf(valueToRemove);
                fieldToRemoveFrom.possibleIndeces.splice(position, 1);
            }
        }
    }
}

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
const [fieldText, ticketText] = fileData.split('your ticket:').map(x => x.trim());

const [yourTicketText, nearbyTicketText] = ticketText.split('nearby tickets:')
                                                     .map(x => x.trim());

const fields = fieldText.split('\n')
                        .map(function(text) {
                            const [name, ranges] = text.split(':').map(x => x.trim());
                            const [range1, range2] = ranges.split('or').map(x => x.trim());
                            const [min1, max1] = range1.split('-').map(x => Number(x));
                            const [min2, max2] = range2.split('-').map(x => Number(x));
                            return {
                                name: name,
                                ranges: [
                                    { min: min1, max: max1 },
                                    { min: min2, max: max2 }
                                ]
                            }
                        });

const yourTicket = yourTicketText.split(',')
                                 .map(x => Number(x));

const nearbyTickets = nearbyTicketText.split('\n')
                                      .map(x => x.split(',')
                                                 .map(num => Number(num))
                                      );

const validTickets = nearbyTickets.filter(isTicketValid);
const ticketValuesPerIndex = getTicketValuesPerIndex(validTickets);

let fieldsWithPossibleIndeces = getAllPossibleIndecesPerField(ticketValuesPerIndex);

while (fieldsWithPossibleIndeces.find(x => !x.foundIndex)) {
    findAndRemoveSingleIndeces(fieldsWithPossibleIndeces);
}

const answer = fieldsWithPossibleIndeces.filter(field => field.name.startsWith('departure'))
                                        .map(field => yourTicket[field.possibleIndeces[0]])
                                        .reduce((accumulator, x) => accumulator * x, 1);

console.log(answer);

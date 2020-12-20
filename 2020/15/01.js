const getNthNumberInSequence = (sequence, n) => {
    let lastOccurrence = new Map();
    for (let i = 0; i < sequence.length - 1; ++i) {
        lastOccurrence.set(sequence[i], i);
    }

    while (sequence.length < n) {
        const lastIndex = sequence.length - 1;
        const lastNum = sequence[lastIndex];
        const nextNum = lastOccurrence.has(lastNum) ? (lastIndex - lastOccurrence.get(lastNum)) : 0;
        lastOccurrence.set(lastNum, lastIndex);
        sequence.push(nextNum);
    }
    return sequence[sequence.length - 1];
}

const input = [2, 0, 6, 12, 1, 3];
console.log("Part 1 - 2020th number: " + getNthNumberInSequence(input, 2020));
console.log("Part 2 - 30000000th number: " + getNthNumberInSequence(input, 30000000));
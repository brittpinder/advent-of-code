const { performance } = require('perf_hooks');

const playCrabCups = (input, inputLength, numMoves) => {
    let currentCup = input[0];

    // Fill in rest of input
    let nextNum = input.length + 1;
    while (input.length < inputLength) {
        input.push(nextNum);
        nextNum++;
    }

    // Convert input to map representing circular doubly linked list
    let cups = new Map();
    for (let i = 1; i < input.length - 1; ++i) {
        cups.set(input[i], {
            last: input[i - 1],
            next: input[i + 1]
        });
    }
    cups.set(input[input.length - 1], {
        last: input[input.length - 2],
        next: input[0]
    });
    cups.set(input[0], {
        last: input[input.length - 1],
        next: input[1]
    });

    const attachCups = (leftCup, rightCup) => {
        cups.set(leftCup, {
            last: cups.get(leftCup).last,
            next: rightCup
        });
        cups.set(rightCup, {
            last: leftCup,
            next: cups.get(rightCup).next
        });
    }

    // Play game
    for (let i = 0; i < numMoves; ++i) {
        // Find three cups to move
        let value = cups.get(currentCup).next;
        let cupsToMove = [value];
     
        for (let i = 0; i < 2; ++i) {
            value = cups.get(value).next;
            cupsToMove.push(value);
        }

        // Find destination cup
        let destinationCup = currentCup - 1;
        while (cupsToMove.includes(destinationCup) || destinationCup < 1) {
            destinationCup--;
            if (destinationCup < 1) {
                destinationCup = inputLength;
            }
        }

        // Remove three cups by attaching their neighbours on either side
        const neighbourLeft = cups.get(cupsToMove[0]).last;
        const neighbourRight = cups.get(cupsToMove[2]).next;
        attachCups(neighbourLeft, neighbourRight);

        // Insert three cups after destination cup
        const destinationLeft = destinationCup;
        const destinationRight = cups.get(destinationCup).next;
        attachCups(destinationLeft, cupsToMove[0]);
        attachCups(cupsToMove[2], destinationRight);
    
        // Choose next current cup
        currentCup = cups.get(currentCup).next;
    }
    return cups;
}

const part1 = (input) => {
    const cups = playCrabCups(input, 9, 100);

    let answer = '';
    let value = cups.get(1).next;
    while (value !== 1) {
        answer = answer.concat(value.toString());
        value = cups.get(value).next;
    }

    console.log("Part 1 Answer: " + answer);
}

const part2 = (input) => {
    const startTime = performance.now();

    const cups = playCrabCups(input, 1000000, 10000000);
    const cup1 = cups.get(1).next;
    const cup2 = cups.get(cup1).next;
    const answer = cup1 * cup2;
    console.log("Part 2 Answer: " + answer);

    const totalTime = (performance.now() - startTime) / 1000;
    console.log("Part 2 Time: " + totalTime + " seconds");
}

const input = [1, 8, 6, 5, 2, 4, 9, 7, 3];
part1(input);
part2(input);
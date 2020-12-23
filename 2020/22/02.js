let fs = require('fs');

const doArraysMatch = (array1, array2) => {
    if (array1.length !== array2.length) {
        return false;
    }
    for (let i = 0; i < array1.length; ++i) {
        if (array1[i] !== array2[i]) {
            return false;
        }
    }
    return true;
}

const playRecursiveCombat = (deck1, deck2) => {
    let configurations = [];

    while (deck1.length > 0 && deck2.length > 0) {
        for (const configuration of configurations) {
            if (doArraysMatch(configuration.deck1, deck1) && doArraysMatch(configuration.deck2, deck2)) {
                return 'deck1';
            }
        }
        configurations.push({
            deck1: [...deck1],
            deck2: [...deck2]
        });

        const card1 = deck1.shift();
        const card2 = deck2.shift();

        let winner = card1 > card2 ? 'deck1' : 'deck2';

        if (deck1.length >= card1 && deck2.length >= card2) {
            let deck1Copy = deck1.slice(0, card1);
            let deck2Copy = deck2.slice(0, card2);
            winner = playRecursiveCombat(deck1Copy, deck2Copy);
        }

        if (winner === 'deck1') {
            deck1.push(card1);
            deck1.push(card2);
        } else {
            deck2.push(card2);
            deck2.push(card1);
        }
    }
    return deck1.length > 0 ? 'deck1' : 'deck2';
}

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
let [player1, player2] = fileData.split('\n\n')
                                 .map(x =>
                                    x.split(':')
                                    [1]
                                    .trim()
                                    .split('\n')
                                    .map(value => Number(value))
                                 );

playRecursiveCombat(player1, player2);

const winningHand = player1.length > 0 ? player1 : player2;
const score = winningHand.map(function(card, index) {
                            return card * (winningHand.length - index);
                         })
                         .reduce((accumulator, x) => accumulator + x);

console.log('Score: ' + score);

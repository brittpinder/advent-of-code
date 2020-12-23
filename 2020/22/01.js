let fs = require('fs');

const playCombat = (deck1, deck2) => {
    while (deck1.length > 0 && deck2.length > 0) {
        const card1 = deck1.shift();
        const card2 = deck2.shift();
        if (card1 > card2) {
            deck1.push(card1);
            deck1.push(card2);
        } else {
            deck2.push(card2);
            deck2.push(card1);
        }
    }
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

playCombat(player1, player2);

const winningHand = player1.length > 0 ? player1 : player2;
const score = winningHand.map(function(card, index) {
                            return card * (winningHand.length - index);
                         })
                         .reduce((accumulator, x) => accumulator + x);

console.log('Score: ' + score);
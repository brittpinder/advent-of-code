let fs = require('fs');

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
const lines = fileData.split("\n");

let rules = new Map();
for (const line of lines) {
    let [type, bags] = line.split(" bags contain ");

    if (isNaN(bags.charAt(0))) {
        bags = [];
    } else {
        bags = bags.split(", ").map(x => x.split(" "))
                               .map(x => {
                                    return {
                                        num: +x[0],
                                        type: x[1] + " " + x[2]
                                    }
                               });
    }
    rules.set(type, bags);
}

let bagsThatHaveShinyGold = new Set();
let bagTypesToCheck = ["shiny gold"];

while (bagTypesToCheck.length > 0) {
    const bagType = bagTypesToCheck[0];
    bagTypesToCheck.shift();

    for (const [type, bags] of rules) {
        for (const bag of bags) {
            if (bag.type === bagType) {
                bagsThatHaveShinyGold.add(type);
                bagTypesToCheck.push(type);
            }
        }
    }
}

console.log(bagsThatHaveShinyGold.size);
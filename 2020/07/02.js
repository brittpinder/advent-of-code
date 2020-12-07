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

const getNumBagsInType = (type) => {
    let sum = 0;
    for (const bag of rules.get(type)) {
        sum += bag.num + bag.num * getNumBagsInType(bag.type);
    }
    return sum;
}

console.log(getNumBagsInType("shiny gold"));
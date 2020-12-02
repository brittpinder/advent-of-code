let fs = require('fs');

const isPasswordValid = data => {
    const [policy, password] = data.split(":").map(x => x.trim());
    const [numbers, letter] = policy.split(" ");
    const [min, max] = numbers.split("-").map(x => +x);
    const numOccurrences = password.split("").filter(x => x === letter).length;
    return numOccurrences >= min && numOccurrences <= max;
}

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
const lines = fileData.split("\n");

const numValidPasswords = lines.map(x => isPasswordValid(x) ? 1 : 0)
                               .reduce((accumulator, x) => accumulator + x);

console.log("Number of valid passwords: " + numValidPasswords);

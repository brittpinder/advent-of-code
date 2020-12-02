let fs = require('fs');

const isPasswordValid = data => {
    const [policy, password] = data.split(":").map(x => x.trim());
    const [numbers, letter] = policy.split(" ");
    const [num1, num2] = numbers.split("-").map(x => +x - 1);
    return password[num1] === letter ^ password[num2] === letter;
}

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
const lines = fileData.split("\n");

const numValidPasswords = lines.map(x => isPasswordValid(x) ? 1 : 0)
                               .reduce((accumulator, x) => accumulator + x);

console.log("Number of valid passwords: " + numValidPasswords);

let fs = require('fs');

const isPassportValid = (passport) => {
    return passport.includes("byr:")
        && passport.includes("iyr:")
        && passport.includes("eyr:")
        && passport.includes("hgt:")
        && passport.includes("hcl:")
        && passport.includes("ecl:")
        && passport.includes("pid:")
}

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
const passports = fileData.split("\n\n");
const numValidPassports = passports.filter(x => isPassportValid(x)).length;

console.log("Number of valid passports: " + numValidPassports);


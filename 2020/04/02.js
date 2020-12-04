let fs = require('fs');
const Passport = require('./Passport.js');

const getPassport = (data) => {
    let dataMap = new Map();
    const passportFields = data.split(/ |\n/);
    for (const field of passportFields) {
        const [key, value] = field.split(":");
        dataMap.set(key, value);
    }
    return new Passport(dataMap);
}

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
const passportData = fileData.split("\n\n");
const numValidPassports = passportData.map(x => getPassport(x))
                                      .filter(x => x.isValid())
                                      .length;

console.log("Number of valid passports: " + numValidPassports);
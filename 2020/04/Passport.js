function Passport(passportMap) {
    this.passportMap = passportMap;
}

Passport.prototype.hasValidBirthYear = function() {
    if (!this.passportMap.has('byr')) {
        return false;
    }
    const birthYear = +this.passportMap.get('byr');
    return birthYear >= 1920 && birthYear <= 2002;
}

Passport.prototype.hasValidIssueYear = function() {
    if (!this.passportMap.has('iyr')) {
        return false;
    }
    const issueYear = +this.passportMap.get('iyr');
    return issueYear >= 2010 && issueYear <= 2020;
}

Passport.prototype.hasValidExpirationYear = function() {
    if (!this.passportMap.has('eyr')) {
        return false;
    }
    const expirationYear = +this.passportMap.get('eyr');
    return expirationYear >= 2020 && expirationYear <= 2030;
}

Passport.prototype.hasValidHeight = function() {
    if (!this.passportMap.has('hgt')) {
        return false;
    }
    const height = this.passportMap.get('hgt');
    if (height.endsWith('in')) {
        const number = +height.substr(0, height.length - 2);
        return number >= 59 && number <= 76;
    } else if (height.endsWith('cm')) {
        const number = +height.substr(0, height.length - 2);
        return number >= 150 && number <= 193;
    }
    return false;
}

Passport.prototype.hasValidHairColor = function() {
    if (!this.passportMap.has('hcl')) {
        return false;
    }
    const hairColor = this.passportMap.get('hcl');
    return /^#[a-f0-9]{6}$/.test(hairColor);
}

Passport.prototype.hasValidEyeColor = function() {
    if (!this.passportMap.has('ecl')) {
        return false;
    }
    const eyeColor = this.passportMap.get('ecl');
    return /^(amb|blu|brn|gry|grn|hzl|oth)$/.test(eyeColor);
}

Passport.prototype.hasValidPassportId = function() {
    if (!this.passportMap.has('pid')) {
        return false;
    }
    const passwordId = this.passportMap.get('pid');
    return /^[0-9]{9}$/.test(passwordId);
}

Passport.prototype.isValid = function() {
    return this.hasValidBirthYear(this.passportMap)
        && this.hasValidIssueYear(this.passportMap)
        && this.hasValidExpirationYear(this.passportMap)
        && this.hasValidHeight(this.passportMap)
        && this.hasValidHairColor(this.passportMap)
        && this.hasValidEyeColor(this.passportMap)
        && this.hasValidPassportId(this.passportMap);
}

module.exports = Passport;
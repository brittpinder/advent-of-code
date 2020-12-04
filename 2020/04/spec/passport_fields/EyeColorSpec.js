const Passport = require('../../Passport.js');

describe("A Passport", function() {
    it("with eye color amb is valid", function() {
        const passport = new Passport(new Map([['ecl','amb']]));
        expect(passport.hasValidEyeColor()).toBe(true);
    });

    it("with eye color blu is valid", function() {
        const passport = new Passport(new Map([['ecl','blu']]));
        expect(passport.hasValidEyeColor()).toBe(true);
    });

    it("with eye color brn is valid", function() {
        const passport = new Passport(new Map([['ecl','brn']]));
        expect(passport.hasValidEyeColor()).toBe(true);
    });

    it("with eye color gry is valid", function() {
        const passport = new Passport(new Map([['ecl','gry']]));
        expect(passport.hasValidEyeColor()).toBe(true);
    });

    it("with eye color grn is valid", function() {
        const passport = new Passport(new Map([['ecl','grn']]));
        expect(passport.hasValidEyeColor()).toBe(true);
    });

    it("with eye color hzl is valid", function() {
        const passport = new Passport(new Map([['ecl','hzl']]));
        expect(passport.hasValidEyeColor()).toBe(true);
    });

    it("with eye color oth is valid", function() {
        const passport = new Passport(new Map([['ecl','oth']]));
        expect(passport.hasValidEyeColor()).toBe(true);
    });

    it("with eye color red is invalid", function() {
        const passport = new Passport(new Map([['ecl','red']]));
        expect(passport.hasValidEyeColor()).toBe(false);
    });

    it("with eye color as hexadecimal is invalid", function() {
        const passport = new Passport(new Map([['ecl','#123abc']]));
        expect(passport.hasValidEyeColor()).toBe(false);
    });
});

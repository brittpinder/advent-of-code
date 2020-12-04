const Passport = require('../../Passport.js');

describe("A Passport", function() {
    it("with birth year before 1920 is invalid", function() {
        const passport = new Passport(new Map([['byr','1919']]));
        expect(passport.hasValidBirthYear()).toBe(false);
    });

    it("with birth year of 1920 is valid", function() {
        const passport = new Passport(new Map([['byr','1920']]));
        expect(passport.hasValidBirthYear()).toBe(true);
    });

    it("with birth year between 1920 and 2002 is valid", function() {
        const passport = new Passport(new Map([['byr','1955']]));
        expect(passport.hasValidBirthYear()).toBe(true);
    });

    it("with birth year of 2002 is valid", function() {
        const passport = new Passport(new Map([['byr','2002']]));
        expect(passport.hasValidBirthYear()).toBe(true);
    });

    it("with birth year after 2002 is invalid", function() {
        const passport = new Passport(new Map([['byr','2003']]));
        expect(passport.hasValidBirthYear()).toBe(false);
    });

    it("with birth year that is not a number is invalid", function() {
        const passport = new Passport(new Map([['byr','nineteentwenty']]));
        expect(passport.hasValidBirthYear()).toBe(false);
    });
});
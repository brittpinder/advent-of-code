const Passport = require('../../Passport.js');

describe("A Passport", function() {
    it("with expiration year before 2020 is invalid", function() {
        const passport = new Passport(new Map([['eyr','2019']]));
        expect(passport.hasValidExpirationYear()).toBe(false);
    });

    it("with expiration year of 2020 is valid", function() {
        const passport = new Passport(new Map([['eyr','2020']]));
        expect(passport.hasValidExpirationYear()).toBe(true);
    });

    it("with expiration year between 2020 and 2030 is valid", function() {
        const passport = new Passport(new Map([['eyr','2025']]));
        expect(passport.hasValidExpirationYear()).toBe(true);
    });

    it("with expiration year of 2030 is valid", function() {
        const passport = new Passport(new Map([['eyr','2030']]));
        expect(passport.hasValidExpirationYear()).toBe(true);
    });

    it("with expiration year after 2030 is invalid", function() {
        const passport = new Passport(new Map([['eyr','2031']]));
        expect(passport.hasValidExpirationYear()).toBe(false);
    });

    it("with expiration year that is not a number is invalid", function() {
        const passport = new Passport(new Map([['eyr','twentytwenty']]));
        expect(passport.hasValidExpirationYear()).toBe(false);
    });
});

const Passport = require('../../Passport.js');

describe("A Passport", function() {
    it("with passport id not a number is invalid", function() {
        const passport = new Passport(new Map([['pid','passportId']]));
        expect(passport.hasValidPassportId()).toBe(false);
    });

    it("with passport id shorter than 9 numbers is invalid", function() {
        const passport = new Passport(new Map([['pid','12345678']]));
        expect(passport.hasValidPassportId()).toBe(false);
    });

    it("with passport id longer than 9 numbers is invalid", function() {
        const passport = new Passport(new Map([['pid','1234567890']]));
        expect(passport.hasValidPassportId()).toBe(false);
    });

    it("with passport id with exactly 9 numbers is valid", function() {
        const passport = new Passport(new Map([['pid','123456789']]));
        expect(passport.hasValidPassportId()).toBe(true);
    });

    it("with passport id with leading zeros is valid", function() {
        const passport = new Passport(new Map([['pid','000123456']]));
        expect(passport.hasValidPassportId()).toBe(true);
    });

    it("with passport id with special characters is invalid", function() {
        const passport = new Passport(new Map([['pid','12345-789']]));
        expect(passport.hasValidPassportId()).toBe(false);
    });
});

const Passport = require('../../Passport.js');

describe("A Passport", function() {
    it("with issue year before 2010 is invalid", function() {
        const passport = new Passport(new Map([['iyr','2009']]));
        expect(passport.hasValidIssueYear()).toBe(false);
    });

    it("with issue year of 2010 is valid", function() {
        const passport = new Passport(new Map([['iyr','2010']]));
        expect(passport.hasValidIssueYear()).toBe(true);
    });

    it("with issue year between 2010 and 2020 is valid", function() {
        const passport = new Passport(new Map([['iyr','2015']]));
        expect(passport.hasValidIssueYear()).toBe(true);
    });

    it("with issue year of 2020 is valid", function() {
        const passport = new Passport(new Map([['iyr','2020']]));
        expect(passport.hasValidIssueYear()).toBe(true);
    });

    it("with issue year after 2020 is invalid", function() {
        const passport = new Passport(new Map([['iyr','2021']]));
        expect(passport.hasValidIssueYear()).toBe(false);
    });

    it("with issue year that is not a number is invalid", function() {
        const passport = new Passport(new Map([['iyr','twentytwenty']]));
        expect(passport.hasValidIssueYear()).toBe(false);
    });
});

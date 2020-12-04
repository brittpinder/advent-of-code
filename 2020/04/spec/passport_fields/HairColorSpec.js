const Passport = require('../../Passport.js');

describe("A Passport", function() {
    it("with hair color that does not start with # is invalid", function() {
        const passport = new Passport(new Map([['hcl','123abc']]));
        expect(passport.hasValidHairColor()).toBe(false);
    });

    it("with hair color that is longer than 6 characters is invalid", function() {
        const passport = new Passport(new Map([['hcl','#123abc1']]));
        expect(passport.hasValidHairColor()).toBe(false);
    });

    it("with hair color that is shorter than 6 characters is invalid", function() {
        const passport = new Passport(new Map([['hcl','#123ab']]));
        expect(passport.hasValidHairColor()).toBe(false);
    });

    it("with hair color that has letters other than a-f is invalid", function() {
        const passport = new Passport(new Map([['hcl','#123gad']]));
        expect(passport.hasValidHairColor()).toBe(false);
    });

    it("with hair color that has characters other than numbers and/or a-f is invalid", function() {
        const passport = new Passport(new Map([['hcl','#-$.,&+']]));
        expect(passport.hasValidHairColor()).toBe(false);
    });

    it("with hair color of hexadecimal format is valid", function() {
        const passport = new Passport(new Map([['hcl','#123abc']]));
        expect(passport.hasValidHairColor()).toBe(true);
    });
});

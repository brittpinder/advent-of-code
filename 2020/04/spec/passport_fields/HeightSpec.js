const Passport = require('../../Passport.js');

describe("A Passport", function() {
    it("with missing height metric is invalid", function() {
        const passport = new Passport(new Map([['hgt','65']]));
        expect(passport.hasValidHeight()).toBe(false);
    });

    it("with height that has metric before number is invalid", function() {
        const passportCm = new Passport(new Map([['hgt','cm175']]));
        expect(passportCm.hasValidHeight()).toBe(false);

        const passportIn = new Passport(new Map([['hgt','in65']]));
        expect(passportIn.hasValidHeight()).toBe(false);
    });

    it("with height that does not end with metric is invalid", function() {
        const passportCm = new Passport(new Map([['hgt','175cm_extra']]));
        expect(passportCm.hasValidHeight()).toBe(false);

        const passportIn = new Passport(new Map([['hgt','65in_extra']]));
        expect(passportIn.hasValidHeight()).toBe(false);
    });

    it("with height that does not start with number is invalid", function() {
        const passportCm = new Passport(new Map([['hgt','extra_175cm']]));
        expect(passportCm.hasValidHeight()).toBe(false);

        const passportIn = new Passport(new Map([['hgt','extra_65in']]));
        expect(passportIn.hasValidHeight()).toBe(false);
    });

    it("with height less than 150cm is invalid", function() {
        const passport = new Passport(new Map([['hgt','149cm']]));
        expect(passport.hasValidHeight()).toBe(false);
    });

    it("with height of 150cm is valid", function() {
        const passport = new Passport(new Map([['hgt','150cm']]));
        expect(passport.hasValidHeight()).toBe(true);
    });

    it("with height between 150cm and 193cm is valid", function() {
        const passport = new Passport(new Map([['hgt','175cm']]));
        expect(passport.hasValidHeight()).toBe(true);
    });

    it("with height of 193cm is valid", function() {
        const passport = new Passport(new Map([['hgt','193cm']]));
        expect(passport.hasValidHeight()).toBe(true);
    });

    it("with height greater than 193cm is invalid", function() {
        const passport = new Passport(new Map([['hgt','194cm']]));
        expect(passport.hasValidHeight()).toBe(false);
    });

    it("with height less than 59in is invalid", function() {
        const passport = new Passport(new Map([['hgt','58in']]));
        expect(passport.hasValidHeight()).toBe(false);
    });

    it("with height of 59in is valid", function() {
        const passport = new Passport(new Map([['hgt','59in']]));
        expect(passport.hasValidHeight()).toBe(true);
    });

    it("with height between 59in and 76in is valid", function() {
        const passport = new Passport(new Map([['hgt','65in']]));
        expect(passport.hasValidHeight()).toBe(true);
    });

    it("with height of 76in is valid", function() {
        const passport = new Passport(new Map([['hgt','76in']]));
        expect(passport.hasValidHeight()).toBe(true);
    });

    it("with height greater than 76in is valid", function() {
        const passport = new Passport(new Map([['hgt','77in']]));
        expect(passport.hasValidHeight()).toBe(false);
    });
});

const element_exists = require("./lib").element_exists;
const jsdom = require("jsdom");
const {
    JSDOM
} = jsdom;

describe("Testing element_exists", function () {
    it("should return true for existing element", function () {
        let dom = new JSDOM(`<!DOCTYPE html> <div id="id-test">hey</div>`);
        global.document = dom.window.document;
        expect(element_exists("id-test")).toBe(true);
    });

    it("should return false for inexisting element", function () {
        let dom = new JSDOM(``); // empty dom
        global.document = dom.window.document;
        expect(element_exists("inexisting-id")).toBe(false);
    });
});

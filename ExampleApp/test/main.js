/**
 * Created by Sam on 2016-05-03.
 */

'use strict';

const Parse = require('parse/node');
const expect = require("chai").expect;

// Constants
const serverURL = 'https://localhost:1337/parse';
const appId = 'parse-server-test-app-id';
const masterKey = 'parse-server-test-master-key';
const clientKey = 'parse-server-test-client-key';

function setUpParse() {
    Parse.initialize(appId, clientKey, masterKey);
    // Parse.User.enableUnsafeCurrentUser(); // Enable logging in users
    Parse.serverURL = serverURL;
}


before(() => {
    setUpParse();
    it("should be set up", () => {
        expect(true).to.equal(true);
    });
});

describe("Main Tests", function() {
this.timeout(0);

    let response = null;
    describe("I call the hello() cloud code function", () => {

        before(done => {
            Parse.Cloud.run("hello", null)
                .then(result => {
                    response = result;
                    done();
                })
                .catch(error => done(error));
        });

        it("I should receive hi as a response", () => {
            expect(response).to.equal('Hi');
        });
    });
});

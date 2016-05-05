'use strict';

const express = require('express');
const ParseServer = require('parse-server').ParseServer;
const path = require('path');

// Create a new express app
const app = express();

// Setup the parse parameters
const parseParameters = {
    serverURL: process.env.SERVER_URL || 'http://localhost:1337/parse',
    databaseURI: process.env.MONGODB_URI || 'mongodb://localhost:27017/dev',
    appId: process.env.PARSE_APP_ID || 'parse-server-test-app-id',
    masterKey: process.env.PARSE_MASTER_KEY || 'parse-server-test-master-key',
    clientKey: process.env.PARSE_CLIENT_KEY || 'parse-server-test-client-key',
    cloud: path.join(__dirname, '/cloud/main.js')
};

// Create a new parse server middleware
const api = new ParseServer(parseParameters);

// Serve the Parse API at /parse URL prefix
app.use('/parse', api);

// Set a greating message
app.get('/', (request, response) => {
    response.send("Hello Parse Test");
});

// Serve static assets from the /public folder
app.use('/public', express.static(path.join(__dirname, '/public')));

// There will be a test page available on the /test path of your server url
// Remove this before launching your app
app.get('/test', (request, response) => {
    response.sendFile(path.join(__dirname, '/public/test.html'));
});

// Listen on port 1337
const port = process.env.PORT || 1337;
app.listen(port, function() {
    console.log(`parse-server-test running on port ${port}.`);
});

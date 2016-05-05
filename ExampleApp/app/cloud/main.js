/**
 * Created by Sam on 2016-03-28.
 */
'use strict';

Parse.Cloud.define('hello', (request, response) => {
    response.success('Hi');
});

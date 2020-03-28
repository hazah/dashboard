/*jshint esversion: 6 */

const channels = require.context('.', true, /_channel\.js$/);
channels.keys().forEach(channels);

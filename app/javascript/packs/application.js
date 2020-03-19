require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();

import "channels";
import "controllers";
import "bootstrap";

document.addEventListener('turbolinks:load', function(event) {
  var messages = document.getElementById("messages");
  messages.scrollTop = messages.scrollHeight;
});
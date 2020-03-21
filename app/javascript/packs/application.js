import Turbolinks from "turbolinks";
import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";

Turbolinks.start();
Rails.start();
ActiveStorage.start();

import "channels";
import "controllers";
import "bootstrap";

import consumer from "../channels/consumer";
import SigningIn from "../sign_in";

document.addEventListener("turbolinks:load", function(event) {
  if (event.data.url.endsWith("/session/new")) {
    SigningIn.signing_in = true;
  } else {
    if (SigningIn) {
      consumer.disconnect();
      consumer.connect();
    }
    SigningIn.signing_in = false;
  }
});

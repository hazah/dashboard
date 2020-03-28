/*jshint esversion: 6 */
import consumer from "./consumer";
import Turbolinks from "turbolinks";

consumer.subscriptions.create("SessionChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    setTimeout(function reconnect() {
      if (data.session) {
        if (document.cookie.match(/user_id=/g)) {
          console.log("disconnecting ...");
          consumer.disconnect();
          consumer.connect();
        } else {
          console.log("resseting ...");
          setTimeout(reconnect);
        }
      } else {
        if (document.cookie.match(/user_id=/g)) {
          console.log("resseting ...");
          setTimeout(reconnect);
        } else {
          console.log("disconnecting ...");
          consumer.disconnect();
          consumer.connect();
        }
      }
    });
    if (data.url) {
      Turbolinks.visit(data.url);
    }
  }
});

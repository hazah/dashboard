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
    console.log("session ended");
    consumer.disconnect();
    consumer.connect();
    
    Turbolinks.visit(data.url);
  }
});

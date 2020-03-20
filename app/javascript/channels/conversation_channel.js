import consumer from "./consumer";

consumer.subscriptions.create({ channel: "ConversationChannel" }, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    let messages = document.getElementById("messages");
    messages.dispatchEvent(new CustomEvent("message:received", { detail: { data: data } }));
  }
});

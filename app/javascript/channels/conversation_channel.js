import consumer from "./consumer";

consumer.subscriptions.create({ channel: "ConversationChannel" }, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    var messages = document.getElementById("messages");
    var template = document.createElement("template");
    
    template.innerHTML = data;
    
    messages.appendChild(template.content.firstChild);
    messages.scrollTop = messages.scrollHeight;
  }
});

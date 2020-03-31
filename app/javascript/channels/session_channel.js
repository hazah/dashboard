/*jshint esversion: 6 */
import consumer from "./consumer";
import Rails from "@rails/ujs";


consumer.subscriptions.create("SessionChannel", {
  connected() {
    Rails.ajax({
      type: 'GET', 
      url: '/session/new',
      dataType: 'script'
    });
  },

  disconnected() {
  },

  received(data) {
    const { session } = data;
    if (session) {
      const { id: user_id } = session;
      
      let self = this;

      this.user_session = consumer.subscriptions.create({ channel: "SessionChannel", user_id: user_id }, {
        
        connected() {
          let self = this;
          
          this.conversation = consumer.subscriptions.create({ channel: "ConversationChannel", user_id: user_id }, {
            connected() {
            },
          
            disconnected() {
            },
          
            received(data) {
              document.getElementById("messages").
                dispatchEvent(
                  new CustomEvent(
                    "message:received", {
                      detail: {
                        data: data
                      }
                    }
                  )
                );
            }
          });

        },

        disconnected() {
        },

        received(data) {
          const { session } = data;
          if (!session) {
            this.conversation.unsubscribe();
          }
        }
      });

    } else {
      this.user_session.unsubscribe();
      this.send(data);
    }
  }
});

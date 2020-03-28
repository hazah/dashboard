/*jshint esversion: 6 */
import { Controller } from "stimulus";
import Rails from "@rails/ujs";
export default class extends Controller {
  static targets = [ "conversations", "conversation" ];
  
  toggle(event) {
    if (!event.shiftKey) {
      this.last = event.target.getAttribute('data-conversation-id');
    }
    if (event.ctrlKey) {
      this.ctrlKeyPressed(event.target);
    } else if (event.shiftKey && this.last.length > 0) {
      this.shiftKeyPressedWithLastSet(event);
    } else {
      this.ctrlKeyNotPressedWithLastNotSet(event);
    }
  }

  set last(value) {
    this.data.set("last", value.trim());
  }
  
  get last() {
    return this.data.get("last");
  }

  ctrlKeyPressed(elem) {
    if (elem.classList.contains('btn-warning')) {
      this.toDelete(elem);
      this.clearLast();
    } else {
      let toStartCount = 0;
      let conversation_ids = [];

      this.conversationTargets.forEach(el => {
        if (el.classList.contains('btn-warning')) {
          ++toStartCount;
          
          const current = el.getAttribute('data-conversation-id').trim();
          conversation_ids.push(current);
        }
      });
      if (toStartCount == 0) {
        this.toPost(elem);
      } else {
        const current = elem.getAttribute('data-conversation-id').trim();
        conversation_ids.push(current);

        this.sendPost(conversation_ids);
        Rails.stopEverything(event);
      }
    }
  }

  shiftKeyPressedWithLastSet(event) {
    if (event.target.getAttribute('data-conversation-id').trim() == this.last) {
      this.toDelete(event.target);
      this.clearLast();
    } else {
      let lastFound = false;
      let targetFound = false;

      let conversation_ids = [];
      
      this.conversationTargets.forEach(el => {
        const current = el.getAttribute('data-conversation-id').trim();

        if (this.last == current) {
          lastFound = true;
          conversation_ids.push(current);
        } else if (el === event.target) {
          targetFound = true;
          conversation_ids.push(current);
        } else if (lastFound && !targetFound || targetFound && !lastFound) {
          conversation_ids.push(current);
        }
      });
      this.sendPost(conversation_ids);

      Rails.stopEverything(event);
    }
  }

  ctrlKeyNotPressedWithLastNotSet(event) {
    let toStartCount = 0;

    this.conversationTargets.forEach(el => {
      if (el.classList.contains('btn-warning')) {
        ++toStartCount;
      }
    });

    if (toStartCount == 1) {
      if (event.target.classList.contains('btn-warning')) {
        this.toDelete(event.target);
        this.clearLast();
      } else {
        this.toPut(event.target);
      }
    } else {
      this.toPost(event.target);
    }
    if (toStartCount != 1 || !event.target.classList.contains('btn-warning')) {
      if (event.shiftKey && this.last.length == 0) {
        this.last = event.target.getAttribute('data-conversation-id');
      }
    }
  }

  clearLast() {
    this.last = "";
  }

  toPut(el) {
    el.setAttribute('href', '/current_conversations/' + el.getAttribute('data-conversation-id'));
    el.setAttribute('data-method', 'put');
    el.removeAttribute('data-params');
  }

  toPost(el) {
    el.setAttribute('href', '/current_conversations');
    el.setAttribute('data-method', 'post');
    el.setAttribute('data-params', 'conversation_id=' + el.getAttribute('data-conversation-id'));
  }

  toDelete(el) {
    el.setAttribute('href', '/current_conversations/' + el.getAttribute('data-conversation-id'));
    el.setAttribute('data-method', 'delete');
    el.removeAttribute('data-params');
  }

  sendPost(conversation_ids) {
    let formData = new FormData();
    
    conversation_ids.forEach(id => {
      formData.append('conversation_ids[]', id);
    });

    Rails.ajax({
      type: 'POST', 
      url: '/current_conversations',
      data: formData,
      dataType: 'script'
    });
  }

  refresh(event) {
    let template = document.createElement("template");
    template.innerHTML = event.detail.data
    let scrollTop = this.conversationsTarget.scrollTop;
    this.conversationsTarget.parentNode.replaceChild(template.content.firstElementChild, this.conversationsTarget);
    this.conversationsTarget.scrollTop = scrollTop;
  }
}

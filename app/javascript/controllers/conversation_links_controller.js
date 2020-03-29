/*jshint esversion: 6 */
import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["conversationLink"];

  get last() {
    return this.data.get("last");
  }

  set last(value) {
    this.data.set("last", `${value}`.trim());
  }

  resetLast() {
    this.last = null;
  }

  index(target) {
    return target.closest("a").getAttribute("data-index").trim();
  }

  id(target) {
    return target.closest("a").getAttribute("data-id").trim();
  }

  is_selected(target) {
    return target.closest("a").classList.contains('btn-primary') || target.closest("a").classList.contains('btn-warning');
  }

  stopEverything(event) {
    Rails.stopEverything(event);
  }

  sendDelete(id) {
    Rails.ajax({
      type: 'DELETE', 
      url: `/current_conversations/${id}`,
      dataType: 'script'
    });
  }

  sendPost(form_data) {
    Rails.ajax({
      type: 'POST', 
      url: '/current_conversations',
      data: form_data,
      dataType: 'script'
    });
  }

  ctrlKeyPressed(event) {
    let target = event.target;
    if (this.is_selected(target)) {
      const current = this.id(target);
      this.sendDelete(current);
      this.stopEverything(event);
      this.resetLast();
    } else {
      let toStartCount = 0;
      let conversation_ids = [];

      this.conversationLinkTargets.forEach((el)=> {
        if (this.is_selected(el)) {
          ++toStartCount;
          
          const current = this.id(el);
          conversation_ids.push(current);
        }
      });
      if (toStartCount == 0) {
        const current = this.id(target);
        let form_data = new FormData();
    
        form_data.append('conversation_id', current);

        this.sendPost(form_data);
        this.stopEverything(event);
      } else {
        const current = this.id(target);
        conversation_ids.push(current);

        let form_data = new FormData();
    
        conversation_ids.forEach(id => {
          form_data.append('conversation_ids[]', id);
        });
        
        this.sendPost(form_data);
        this.stopEverything(event);
      }
    }
  }

  shiftKeyPressedWithLastSet(event) {
    let target = event.target;
    let index = null;
    this.conversationLinkTargets.forEach((el, i) => {
      if (this.id(el) == this.id(target)) {
        index = i;
      }
    });
    if (index == this.last) {
      const current = this.id(target);
      this.sendDelete(current);
      this.stopEverything(event);
      this.resetLast();
    } else {
      let lastFound = false;
      let targetFound = false;

      let conversation_ids = [];
      
      this.conversationLinkTargets.forEach((el, i) => {
        const current = this.id(el);

        if (this.last == i) {
          lastFound = true;
          conversation_ids.push(current);
        } else if (this.id(el) === this.id(target)) {
          targetFound = true;
          conversation_ids.push(current);
        } else if (lastFound && !targetFound || targetFound && !lastFound) {
          conversation_ids.push(current);
        }
      });
      let form_data = new FormData();
    
      conversation_ids.forEach(id => {
        form_data.append('conversation_ids[]', id);
      });

      this.sendPost(form_data);
      this.stopEverything(event);
    }
  }

  ctrlKeyNotPressedWithLastNotSet(event) {
    let target = event.target;
    let toStartCount = 0;

    this.conversationLinkTargets.forEach(el => {
      if (this.is_selected(el)) {
        ++toStartCount;
      }
    });

    if (toStartCount == 1) {
      if (this.is_selected(target)) {
        const current = this.id(target);
        this.sendDelete(current);
        this.stopEverything(event);
        this.resetLast();
      }
    } else {
      let conversation_ids = [];
      const current = this.id(target);
      conversation_ids.push(current);
      
      let form_data = new FormData();
  
      conversation_ids.forEach(id => {
        form_data.append('conversation_ids[]', id);
      });
      
      this.sendPost(form_data);
      this.stopEverything(event);
    }
    if (toStartCount != 1 || !this.is_selected(target)) {
      if (event.shiftKey && this.last.length == 0) {
        this.last = this.index(target);
      }
    }
  }

  toggle(event) {
    if (!event.shiftKey) {
      this.last = this.index(event.target);
    }
    if (event.ctrlKey) {
      this.ctrlKeyPressed(event);
    } else if (event.shiftKey && this.last.length > 0) {
      this.shiftKeyPressedWithLastSet(event);
    } else {
      this.ctrlKeyNotPressedWithLastNotSet(event);
    }
  }
}

import { Controller } from "stimulus";
import Rails from "@rails/ujs";
export default class extends Controller {
  static targets = [ "agent" ];
  
  toggle(event) {
    if (!event.shiftKey) {
      this.last = event.target.getAttribute('data-agent-id');
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

  ctrlKeyPressed(el) {
    if (!el.classList.contains('btn-secondary')) {
      this.toPost(el);
    } else {
      this.toDelete(el);
      this.clearLast();
    }
  }

  shiftKeyPressedWithLastSet(event) {
    if (event.target.getAttribute('data-agent-id').trim() == this.last) {
      this.toDelete(event.target);
      this.clearLast();
    } else {
      let lastFound = false;
      let targetFound = false;

      let agent_ids = [];
      
      this.agentTargets.forEach(el => {
        const current = el.getAttribute('data-agent-id').trim();

        if (this.last == current) {
          lastFound = true;
          agent_ids.push(current);
        } else if (el === event.target) {
          targetFound = true;
          agent_ids.push(current);
        } else if (lastFound && !targetFound || targetFound && !lastFound) {
          agent_ids.push(current);
        }
      });
      this.sendPost(agent_ids);

      Rails.stopEverything(event);
    }
  }

  ctrlKeyNotPressedWithLastNotSet(event) {
    let toStartCount = 0;

    this.agentTargets.forEach(el => {
      if (el.classList.contains('btn-secondary')) {
        ++toStartCount;
      }
    });

    if (toStartCount == 1) {
      if (event.target.classList.contains('btn-secondary')) {
        this.toDelete(event.target);
        this.clearLast();
      } else {
        this.toPut(event.target);
      }
    } else {
      this.toPost(event.target);
    }
    if (toStartCount != 1 || !event.target.classList.contains('btn-secondary')) {
      if (event.shiftKey && this.last.length == 0) {
        this.last = event.target.getAttribute('data-agent-id');
      }
    }
  }

  clearLast() {
    this.last = "";
  }

  toPut(el) {
    el.setAttribute('href', '/current_agents/' + el.getAttribute('data-agent-id'));
    el.setAttribute('data-method', 'put');
    el.removeAttribute('data-params');
  }

  toPost(el) {
    el.setAttribute('href', '/current_agents');
    el.setAttribute('data-method', 'post');
    el.setAttribute('data-params', 'agent_id=' + el.getAttribute('data-agent-id'));
  }

  toDelete(el) {
    el.setAttribute('href', '/current_agents/' + el.getAttribute('data-agent-id'));
    el.setAttribute('data-method', 'delete');
    el.removeAttribute('data-params');
  }

  sendPost(agent_ids) {
    let formData = new FormData();
    
    agent_ids.forEach(id => {
      formData.append('agent_ids[]', id);
    });

    Rails.ajax({
      type: 'POST',
      url: '/current_agents',
      data: formData,
      dataType: 'script'
    });
  }
}

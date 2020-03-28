/*jshint esversion: 6 */
import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["networkLink"];

  get last() {
    return this.data.get("last");
  }

  set last(value) {
    this.data.set("last", `${value}`.trim());
  }

  resetLast() {
    this.last = null;
  }

  id(target) {
    return target.closest("a").getAttribute("data-id").trim();
  }

  is_selected(target) {
    return target.closest("a").classList.contains('btn-secondary');
  }

  stopEverything(event) {
    Rails.stopEverything(event);
  }

  sendDelete(id) {
    Rails.ajax({
      type: 'DELETE', 
      url: `/current_profiles/${id}`,
      dataType: 'script'
    });
  }

  sendPost(form_data) {
    Rails.ajax({
      type: 'POST', 
      url: '/current_profiles',
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
      let profile_ids = [];

      this.networkLinkTargets.forEach(el => {
        if (el.classList.contains('btn-secondary')) {
          ++toStartCount;
          
          const current = el.getAttribute('data-id').trim();
          profile_ids.push(current);
        }
      });
      if (toStartCount == 0) {
        const current = this.id(target);
        profile_ids.push(current);
        
        let form_data = new FormData();
    
        profile_ids.forEach(id => {
          form_data.append('profile_id', id);
        });

        this.sendPost(form_data);
        this.stopEverything(event);
      } else {
        const current = this.id(target);
        profile_ids.push(current);
        
        let form_data = new FormData();
    
        profile_ids.forEach(id => {
          form_data.append('profile_ids[]', id);
        });
        
        this.sendPost(form_data);
        this.stopEverything(event);
      }
    }
  }

  shiftKeyPressedWithLastSet(event) {
    let target = event.target;
    if (this.id(target) == this.last) {
      const current = this.id(target);
      this.sendDelete(current);
      this.stopEverything(event);
      this.resetLast();
    } else {
      let lastFound = false;
      let targetFound = false;

      let profile_ids = [];
      
      this.networkLinkTargets.forEach(el => {
        const current = el.getAttribute('data-id').trim();

        if (this.last == current) {
          lastFound = true;
          profile_ids.push(current);
        } else if (el === event.target) {
          targetFound = true;
          profile_ids.push(current);
        } else if (lastFound && !targetFound || targetFound && !lastFound) {
          profile_ids.push(current);
        }
      });
      let form_data = new FormData();
    
      profile_ids.forEach(id => {
        form_data.append('profile_ids[]', id);
      });

      this.sendPost(form_data);
      this.stopEverything(event);
    }
  }

  ctrlKeyNotPressedWithLastNotSet(event) {
    let target = event.target;
    let toStartCount = 0;

    this.networkLinkTargets.forEach(el => {
      if (el.classList.contains('btn-secondary')) {
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
      let profile_ids = [];
      const current = this.id(target);
      profile_ids.push(current);
      
      let form_data = new FormData();
  
      profile_ids.forEach(id => {
        form_data.append('profile_ids[]', id);
      });
      
      this.sendPost(form_data);
      this.stopEverything(event);
    }
    if (toStartCount != 1 || !this.is_selected(target)) {
      if (event.shiftKey && this.last.length == 0) {
        this.last = target.getAttribute('data-profile-id');
      }
    }
  }

  toggle(event) {
    if (!event.shiftKey) {
      this.last = this.id(event.target);
    }
    if (event.ctrlKey) {
      this.ctrlKeyPressed(event);
    } else if (event.shiftKey && this.last.length > 0) {
      this.shiftKeyPressedWithLastSet(event)
    } else {
      this.ctrlKeyNotPressedWithLastNotSet(event)
    }
  }
}

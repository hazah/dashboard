/*jshint esversion: 6 */
import { Controller } from "stimulus";
import Rails from "@rails/ujs";
export default class extends Controller {
  static targets = [ "profile" ];
  
  toggle(event) {
    if (!event.shiftKey) {
      this.last = event.target.getAttribute('data-profile-id');
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
    if (elem.classList.contains('btn-secondary')) {
      this.toDelete(elem);
      this.clearLast();
    } else {
      let toStartCount = 0;
      let profile_ids = [];

      this.profileTargets.forEach(el => {
        if (el.classList.contains('btn-secondary')) {
          ++toStartCount;
          
          const current = el.getAttribute('data-profile-id').trim();
          profile_ids.push(current);
        }
      });
      if (toStartCount == 0) {
        this.toPost(elem);
      } else {
        const current = elem.getAttribute('data-profile-id').trim();
        profile_ids.push(current);

        this.sendPost(profile_ids);
        Rails.stopEverything(event);
      }
    }
  }

  shiftKeyPressedWithLastSet(event) {
    if (event.target.getAttribute('data-profile-id').trim() == this.last) {
      this.toDelete(event.target);
      this.clearLast();
    } else {
      let lastFound = false;
      let targetFound = false;

      let profile_ids = [];
      
      this.profileTargets.forEach(el => {
        const current = el.getAttribute('data-profile-id').trim();

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
      this.sendPost(profile_ids);

      Rails.stopEverything(event);
    }
  }

  ctrlKeyNotPressedWithLastNotSet(event) {
    let toStartCount = 0;

    this.profileTargets.forEach(el => {
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
        this.last = event.target.getAttribute('data-profile-id');
      }
    }
  }

  clearLast() {
    this.last = "";
  }

  toPut(el) {
    el.setAttribute('href', '/current_profiles/' + el.getAttribute('data-profile-id'));
    el.setAttribute('data-method', 'put');
    el.removeAttribute('data-params');
  }

  toPost(el) {
    el.setAttribute('href', '/current_profiles');
    el.setAttribute('data-method', 'post');
    el.setAttribute('data-params', 'profile_id=' + el.getAttribute('data-profile-id'));
  }

  toDelete(el) {
    el.setAttribute('href', '/current_profiles/' + el.getAttribute('data-profile-id'));
    el.setAttribute('data-method', 'delete');
    el.removeAttribute('data-params');
  }

  sendPost(profile_ids) {
    let formData = new FormData();
    
    profile_ids.forEach(id => {
      formData.append('profile_ids[]', id);
    });

    Rails.ajax({
      type: 'POST',
      url: '/current_profiles',
      data: formData,
      dataType: 'script'
    });
  }
}

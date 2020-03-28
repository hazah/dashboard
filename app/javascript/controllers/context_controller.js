/*jshint esversion: 6 */
import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = [ "button" ];

  id(target) {
    return target.closest("button").getAttribute("data-id").trim();
  }

  is_selected(target) {
    return target.closest("button").classList.contains('btn-secondary');
  }

  stopEverything(event) {
    Rails.stopEverything(event);
  }

  sendDelete(form_data) {
    Rails.ajax({
      type: 'DELETE', 
      url: `/current_location`,
      data: form_data,
      dataType: 'script'
    });
  }

  sendPost(form_data) {
    Rails.ajax({
      type: 'POST', 
      url: '/current_location',
      data: form_data,
      dataType: 'script'
    });
  }

  toggle(event) {
    let target = event.target;
    let anyToStart = false;
    let anyActive = false;

    this.buttonTargets.forEach(el => {
      anyToStart = anyToStart || el.classList.contains('btn-secondary');
      anyActive = anyActive || el === target.closest("button") && !el.classList.contains('btn-secondary');
    });

    if (!anyActive) {
      const current = this.id(target);
      let form_data = new FormData();
  
      form_data.append('id', current);

      this.sendDelete(form_data);
      this.stopEverything(event);
    } else if (!anyToStart) {
      const current = this.id(target);
      let form_data = new FormData();
  
      form_data.append('location_id', current);

      this.sendPost(form_data);
      this.stopEverything(event);
    }
  }
}

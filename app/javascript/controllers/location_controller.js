import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "button" ];

  toggle(event) {
    let anyToStart = false;
    let anyActive = false;
    let form = event.target.parentNode;
    let method = form.querySelector("input[name='_method']");

    this.buttonTargets.forEach(el => {
      anyToStart = anyToStart || el.classList.contains('btn-secondary');
      anyActive = anyActive || el === event.target && !el.classList.contains('btn-secondary');
    });

    if (!anyActive) {
      method.value = 'delete';
      let idField = form.querySelector("input[name='location_id']");
      if (idField) {
        idField.setAttribute("name", "id");
      }
    } else if (!anyToStart) {
      method.value = 'post';
      let idField = form.querySelector("input[name='id']");
      if (idField) {
        idField.setAttribute("name", "location_id");
      }
    } else if (method.value != 'put') {
      method.value = 'put';
      let idField = form.querySelector("input[name='location_id']");
      if (idField) {
        idField.setAttribute("name", "id");
      }
    }
  }
}

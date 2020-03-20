import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    this.element.scrollTop = this.element.scrollHeight;
  }

  received(event) { console.log(event);
    var template = document.createElement("template");
    
    template.innerHTML = event.detail.data;
    
    this.element.appendChild(template.content.firstChild);
    this.element.scrollTop = this.element.scrollHeight;
  }
}

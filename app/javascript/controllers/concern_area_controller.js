import { Controller } from "stimulus";

export default class extends Controller {
  update(event) {
    var template = document.createElement("template");
    
    template.innerHTML = event.detail;
    
    this.element.parentNode.replaceChild(template.content.firstChild, this.element);
  }
}
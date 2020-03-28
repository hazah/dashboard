/*jshint esversion: 6 */
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [
    "network", 
    "networkLinks", 
    "conversationLinks", 
    "messages",
    "newMessage", 
    "context", 
    "concernArea"
  ];

  refresh(event) {
    let template = document.createElement("template");
    template.innerHTML = event.detail.data;
    let scrollTop = this[`${event.detail.target}Target`].scrollTop;
    this[`${event.detail.target}Target`].parentNode.replaceChild(template.content.firstElementChild, this[`${event.detail.target}Target`]);
    this[`${event.detail.target}Target`].scrollTop = scrollTop;
  }
}

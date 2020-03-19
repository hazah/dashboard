import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "send", "message" ];

  keypress(event) {
    if (event.keyCode == 13 && !event.shiftKey) {
      event.preventDefault();
      this.sendTarget.click();
    }
  }

  send(event) {
    if (this.messageTarget.value.trim() === "") {
      event.preventDefault();
    }
  }
}

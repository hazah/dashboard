/*jshint esversion: 6 */
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["menu"];

  menu() {
    let menu = this.menuTarget;
    
    if (menu.style.display == "none") {
      menu.style.display = "block";
    } else if (menu.style.display == "block") {
      menu.style.display = "none";
    } else {
      menu.style.display = "block";
    }
  }
}

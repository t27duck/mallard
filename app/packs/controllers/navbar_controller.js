import { Controller } from "@hotwired/stimulus"
import {enter, leave} from "el-transition";

export default class extends Controller {
  static targets = ["userMenu", "mobileMenu"]

  toggleUserMenu() {
    if(this.userMenuTarget.classList.contains('hidden')) {
      enter(this.userMenuTarget)
    } else {
      leave(this.userMenuTarget)
    }
  }

  toggleMobileMenu() {
    this.mobileMenuTarget.classList.toggle("hidden")
    this.mobileMenuTarget.classList.toggle("block")
  }
}

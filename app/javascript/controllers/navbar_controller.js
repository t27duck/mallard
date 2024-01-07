import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["userMenu", "mobileMenu"]

  toggleUserMenu() {
    this.userMenuTarget.classList.toggle("hidden")
    this.userMenuTarget.classList.toggle("block")
  }

  toggleMobileMenu() {
    this.mobileMenuTarget.classList.toggle("hidden")
    this.mobileMenuTarget.classList.toggle("block")
  }
}

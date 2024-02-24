import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]

  connect() {
    setTimeout(() => { this.close(); }, 3000)
  }

  close(event) {
    if (event) {
      event.preventDefault()
    }
    this.contentTarget.addEventListener('transitionend', () => this.contentTarget.remove());
    this.contentTarget.style.opacity = '0'
  }
}

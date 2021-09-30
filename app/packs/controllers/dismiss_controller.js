import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]

  close(event) {
    event.preventDefault()
    this.contentTarget.addEventListener('transitionend', () => this.contentTarget.remove());
    this.contentTarget.style.opacity = '0'
  }
}

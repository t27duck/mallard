import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  click(event) {
    if (event) {
      event.preventDefault()
    }

    if (this.hasUrlValue) {
      window.open(this.urlValue, "_blank", "noopener,noreferrer")
    }
  }
}

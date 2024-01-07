import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    name: String,
    preventDefault: { type: Boolean, default: false }
  }

  emit(event) {
    if (this.preventDefaultValue) {
      event.preventDefault()
    }

    window.dispatchEvent(new CustomEvent(this.nameValue))
  }
}

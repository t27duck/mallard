import Rails from "@rails/ujs";
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "controls", "list", "opened", "title"]

  connect() {
    window.addEventListener("resize", this.updateDimensions);
    this.updateDimensions()

    window.addEventListener("keyup", this.keyPressed.bind(this));

    // While there is a turbo event for when applying stream changes start, there
    // is not one for when turbo finishes streams. Instead, we can monitor the
    // element that will hold an incoming entry and watch for dom changes in there.
    this.observer = new MutationObserver(this.mutationCallback.bind(this))
  }

  disconnect() {
    window.removeEventListener("resize", this.updateDimensions);
    window.removeEventListener("keyup", this.keyPressed)

    this.observer.disconnect()
  }

  keyPressed(event) {
    const key = event.key

    if (key === "j") {
      this.next(event)
    }
    if (key === "k") {
      this.prev(event)
    }
  }

  mutationCallback(mutations, observer) {
    if (this.hasOpenedTarget) {
      this.openedTarget.closest("li").scrollIntoView()
    }
  }

  updateDimensions() {
    if (this.hasControlsTarget) {
      // 100 is arbitrary, but seems to make things look good enough.
      const offset = this.controlsTarget.offsetHeight + 100
      this.listTarget.style.height = (window.innerHeight - offset) + "px"
    }
  }

  viewEntry(event) {
    event.preventDefault()
    const form = event.target.closest("form")
    const li = event.target.closest("li")
    // Start watching for dom changes within the LI. A change means the frame rendered.
    this.observer.observe(li, { childList: true, subtree: true });
    Rails.fire(form, "submit");
  }

  next(event) {
    event.preventDefault()
    let nextTitle;
    if (this.hasOpenedTarget) {
      nextTitle = this.openedTarget.closest("li").nextElementSibling?.querySelector("a")
    } else {
      nextTitle = this.titleTargets[0];
    }

    if (nextTitle) {
      nextTitle.click()
    }
  }

  prev(event) {
    event.preventDefault()
    let prevTitle

    if (this.hasOpenedTarget) {
      prevTitle = this.openedTarget.closest("li").previousElementSibling?.querySelector("a")
    }

    if (prevTitle) {
      prevTitle.click()
    }
  }

  clearOpened() {
    // Stop existing observing of changes
    this.observer.disconnect()
    this.openedTargets.forEach((elm) => {
      elm.remove()
    })
  }
}

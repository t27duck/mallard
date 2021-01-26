import { Controller } from "stimulus"
import {enter, leave} from "el-transition";

export default class extends Controller {
  static targets = ["outer", "overlay", "body"]

  open(event) {
    enter(this.outerTarget)
    enter(this.overlayTarget)
    enter(this.bodyTarget)
  }

  close(event) {
    event.preventDefault()

    leave(this.overlayTarget)
    leave(this.bodyTarget)
    leave(this.outerTarget)
  }

  onFormSubmitComplete(event) {
    if (event.detail?.formSubmission?.result?.success === false) {
      return
    }

    this.close(event)
  }
}

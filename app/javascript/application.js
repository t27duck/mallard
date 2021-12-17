// Entry point for the build script in your package.json
import { Turbo } from "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener("DOMContentLoaded", () => {
  // The default of 500ms is too long and
  // users can lose the causal link between clicking
  // a link and seeing the browser respond
  Turbo.setProgressBarDelay(100)
})

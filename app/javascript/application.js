import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import { registerControllers } from "controllers"

const application = Application.start()
registerControllers(application)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
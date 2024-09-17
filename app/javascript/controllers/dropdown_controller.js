import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "menu" ]

  connect() {
    console.log("Dropdown controller connected")
  }

  toggle() {
    console.log("Toggle method called")
    this.menuTarget.classList.toggle('hidden')
  }

  hide(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add('hidden')
    }
  }

  disconnect() {
    document.removeEventListener('click', this.hide.bind(this))
  }
}
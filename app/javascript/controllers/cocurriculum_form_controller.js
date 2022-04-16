import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cocurriculum-form"
export default class extends Controller {
  connect() {
  }
  submitEnd(e) {
    if (e.detail.success) {
      this.hideModal()
    }
  }

  hideModal() {
    this.element.remove()
  }
}

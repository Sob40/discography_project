// app/javascript/controllers/nested_fields_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "template"]

  connect() {
    console.log("NestedFieldsController connected")
  }

  add(event) {
    event.preventDefault()
    const newId = new Date().getTime()
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, newId)
    this.containerTarget.insertAdjacentHTML("beforeend", content)
  }

  remove(event) {
    event.preventDefault()
    console.log("Remove action triggered")
    const item = event.currentTarget.closest(".nested-field")
    if (item) {
      const destroyField = item.querySelector("input[name*='[_destroy]']")
      if (destroyField) {
        destroyField.value = "1"
        item.style.display = "none"
      } else {
        item.remove()
      }
    }
  }
}
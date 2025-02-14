import { Controller } from "@hotwired/stimulus"
import SlimSelect from "slim-select"

export default class extends Controller {
  static targets = ["field"]

  connect() {
    console.log("Slim controller connected")
    this.slim = new SlimSelect({
      select: this.fieldTarget,
      placeholder: 'Select authors',
      allowDeselect: true,
      onChange: (info) => {
        console.log("Selected authors:", info);
      }
    });
  }

  disconnect() {
    if (this.slim) this.slim.destroy()
  }
}
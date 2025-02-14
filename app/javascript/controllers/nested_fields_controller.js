import { Controller } from "@hotwired/stimulus";
import SlimSelect from "slim-select";

export default class extends Controller {
  static targets = ["container", "template"];

  connect() {
    this.initializeSlimSelects();
  }

  add(event) {
    event.preventDefault();
    const newId = new Date().getTime();
    let content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, newId);

    this.containerTarget.insertAdjacentHTML("beforeend", content);

    const newField = this.containerTarget.lastElementChild;
    const songNameInput = newField.querySelector("input[type='text']");
    if (songNameInput) {
      songNameInput.classList.add("song-name-input");
    }

    const authorSelect = newField.querySelector("select");
    if (authorSelect) {
      authorSelect.classList.add("author-select");
    }

    this.initializeSlimSelects();
  }

  remove(event) {
    event.preventDefault();
    const item = event.currentTarget.closest(".nested-field");
    if (item) {
      const destroyField = item.querySelector("input[name*='[_destroy]']");
      if (destroyField) {
        destroyField.value = "1";
        item.style.display = "none";
      } else {
        item.remove();
      }
    }
  }

  initializeSlimSelects() {
    this.containerTarget.querySelectorAll("select.author-select").forEach((select) => {
      if (!select.dataset.slimInitialized) {
        new SlimSelect({
          select: select,
          allowDeselect: true,
          onChange: () => {}
        });
        select.dataset.slimInitialized = "true";
      }
    });
  }
}
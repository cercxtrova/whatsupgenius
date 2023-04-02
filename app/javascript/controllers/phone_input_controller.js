import { Controller } from "@hotwired/stimulus"
import intlTelInput from "intl-tel-input"

export default class extends Controller {
  static targets = ["input", "output", "submit"];

  connect() {
    this.disableSubmit()

    this.phoneInput = intlTelInput(this.inputTarget, {
      utilsScript: "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.21/js/utils.min.js"
    })
  }

  getNumber() {
    if (this.phoneInput.isValidNumber()) {
      this.enableSubmit()
      this.inputTarget.value = this.phoneInput.getNumber()
    } else {
      this.disableSubmit()
    }
  }

  // private

  disableSubmit() {
    this.submitTarget.disabled = true
    this.submitTarget.classList.remove("cursor-pointer")
    this.submitTarget.classList.add("opacity-75", "cursor-not-allowed")
  }

  enableSubmit() {
    this.submitTarget.disabled = false
    this.submitTarget.classList.add("cursor-pointer")
    this.submitTarget.classList.remove("opacity-75", "cursor-not-allowed")
  }
}

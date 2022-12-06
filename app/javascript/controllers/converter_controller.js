import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="converter"
export default class extends Controller {
  static targets = ["number", "button"]

  connect() {
    this.plusOne()
  }

  plusOne() {
    const addOne = () => {
      let n = Number.parseInt(this.numberTarget.innerHTML, 10)
      n++
      this.numberTarget.innerHTML = n
      this.buttonTarget.classList.add('btn-success')
      this.buttonTarget.classList.remove('btn-success')
    }
    setInterval(addOne, 1000)
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  static targets = ["content"]

  connect() {
    console.log("iaee")
  }

  displayContent() {
    console.log('deu boa')
  }
}

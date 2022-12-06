import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carousel"
export default class extends Controller {
  static targets =["card"]
  connect() {
    console.log(this.cardTargets)
    this.cardTargets[this.cardTargets.length -1 ].classList.add("d-none")
  }

  rotate(event) {
    console.log(event)
    this.firstCard = this.cardTargets.shift()
    this.cardTargets.push(this.firstCard)
    this.cardTargets.forEach(card => {
      if (this.cardTargets.indexOf(card) <= 3){
        card.classList.remove("d-none")
      }
      if (this.cardTargets.indexOf(card) > 3){
        card.classList.add("d-none")

      }
    })

  }
}

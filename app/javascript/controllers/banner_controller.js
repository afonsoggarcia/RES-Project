import { Controller } from "@hotwired/stimulus"
import anime from "animejs"

// Connects to data-controller="banner"
export default class extends Controller {
  connect() {
    console.log("oi")
    this.element.innerHTML = this.element.textContent.replace(/\S/g, "<span class='letter'>$&</span>");
    anime.timeline({loop: true})
    .add({
      targets: '.animejs .letter',
      translateY: [100,0],
      translateZ: 0,
      opacity: [0,1],
      easing: "easeOutExpo",
      duration: 1400,
      delay: (el, i) => 300 + 30 * i
    }).add({
      targets: '.animejs .letter',
      translateY: [0,-100],
      opacity: [1,0],
      easing: "easeInExpo",
      duration: 1200,
      delay: (el, i) => 100 + 30 * i
    });
  }
}

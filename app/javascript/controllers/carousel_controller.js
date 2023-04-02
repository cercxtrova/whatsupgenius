import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide", "dot"]

  initialize() {
    this.currentSlide = 0
    this.showSlide(this.currentSlide)

    this.slideInterval = setInterval(() => {
      this.next()
    }, 8000)
  }

  next() {
    this.showSlide((this.currentSlide + 1) % this.slideTargets.length)
  }

  previous() {
    this.showSlide(
      (this.currentSlide - 1 + this.slideTargets.length) % this.slideTargets.length
    );
  }

  showSlide(index) {
    this.slideTargets.forEach((slide, i) => {
      slide.classList.toggle("hidden", i !== index)
      let dot = this.dotTargets[i]
      dot.classList.toggle("bg-gray-200", i === index)
      dot.classList.toggle("bg-gray-400", i !== index)
    })

    this.currentSlide = index
  }

  dotClicked(event) {
    clearInterval(this.slideInterval)

    const index = this.dotTargets.indexOf(event.currentTarget)
    this.showSlide(index)
  }
}

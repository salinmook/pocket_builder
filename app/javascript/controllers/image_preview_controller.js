import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fileInput", "hiddenInput", "previewList", "counter", "addButtonWrapper"]
  static values = { max: Number, existingCount: Number }

  connect() {
    this.selectedFiles = []
  }

  addFile(event) {
    const file = event.target.files[0]
    if (!file) return

    const totalCount = this.existingCountValue + this.selectedFiles.length
    if (totalCount >= this.maxValue) {
      alert(`You can only have ${this.maxValue} photos total.`)
      event.target.value = ""
      return
    }

    this.selectedFiles.push(file)
    this.renderPreviews()
    this.syncHiddenInput()
    event.target.value = ""
  }

  removeFile(event) {
    const index = parseInt(event.currentTarget.dataset.index, 10)
    this.selectedFiles.splice(index, 1)
    this.renderPreviews()
    this.syncHiddenInput()
  }

  renderPreviews() {
    this.previewListTarget.innerHTML = ""

    this.selectedFiles.forEach((file, index) => {
      const reader = new FileReader()
      reader.onload = (e) => {
        const wrapper = document.createElement("span")
        wrapper.style.display = "inline-block"
        wrapper.style.textAlign = "center"

        const img = document.createElement("img")
        img.src = e.target.result
        img.width = 150

        const removeBtn = document.createElement("button")
        removeBtn.type = "button"
        removeBtn.textContent = "Remove"
        removeBtn.dataset.index = index
        removeBtn.dataset.action = "click->image-preview#removeFile"
        removeBtn.style.display = "block"
        removeBtn.style.margin = "4px auto"

        wrapper.appendChild(img)
        wrapper.appendChild(removeBtn)
        this.previewListTarget.appendChild(wrapper)
      }
      reader.readAsDataURL(file)
    })

    const totalCount = this.existingCountValue + this.selectedFiles.length
    this.counterTarget.textContent = `${totalCount}/${this.maxValue} photos selected`

    if (totalCount >= this.maxValue) {
      this.addButtonWrapperTarget.style.display = "none"
    } else {
      this.addButtonWrapperTarget.style.display = "block"
    }
  }

  syncHiddenInput() {
    const dataTransfer = new DataTransfer()
    this.selectedFiles.forEach((file) => dataTransfer.items.add(file))
    this.hiddenInputTarget.files = dataTransfer.files
  }
}
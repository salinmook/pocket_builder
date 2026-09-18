import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["map"]
    static values = { lat: Number, lng: Number }

    connect() {
        if (window.googleMapsReady) {
            this.initMap()
        } else {
            document.addEventListener("google-maps-ready", () => this.initMap(), { once: true })
        }
    }
    initmap() {
        const map = new google.maps.Map(this.mapTarget, {
            center: { lat: this.latValue, lng: this.lngValue },
            zoom: 15
        })
        new google.maps.Marker({
            position: { lat: this.latValue, lng: this.lngValue },
            map: map
        })
    }
}
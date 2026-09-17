import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["map", "address", "latitude", "longitude"]
    static values = { lat: Number, lng: Number }

    connect() {
        if (window.googleMapsReady) {
            this.initMap()
        } else {
            document.addEventListener("google-maps-ready", () => this.initMap(), { once: true })
        }
    }
    initMap() {
        const defaultLat = this.hasLatValue && this.latValue !== 0 ? this.latValue : 48.8566
        const defaultLng = this.haslngValue && this.lngValue !== 0 ? this.lngValue : 2.3522

        this.map = new google.maps.Map(this.mapTarget, {
            center: { lat: defaultLat, lng: defaultLng },
            zoom: 13
        })
        this.marker = new google.maps.Marker({
            position: { lat: defaultLat, lng: defaultLng },
            map: this.map,
            draggable: true
        })
        this.marker.addListener("dragend", () => {
            const position = this.marker.getPosition()
            this.updateCoordinates(position.lat(), position.lng())
        })
        this.map.addListener("click", (event) => {
            const lat = event.latLng.lat()
            const lng = event.latLng.lng()
            this.marker.setPosition({ lat, lng })
            this.updateCoordinates(lat, lng)
        })

        if (this.hasAddressTarget) {
            const autocomplete = new google.maps.places.Autocomplete(this.addressTarget)
            autocomplete.addListener("place_changed", () => {
                const place = autocomplete.getPlace()
                if (!place.geometry) return
                const lat = place.geometry.location.lat()
                const lng = place.geometry.location.lng()
                this.map.setCenter({ lat, lng })
                this.marker.setPosition({ lat, lng })
                this.updateCoordinates(lat, lng)
            })
        } 
    }
    updateCoordinates(lat, lng) {
        this.latitudeTarget.value = lat
        this.longitudeTarget.value = lng
    }
}
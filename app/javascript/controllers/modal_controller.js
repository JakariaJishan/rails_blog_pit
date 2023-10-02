
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["modal", "form"]

    open(event) {
        event.preventDefault();

        this.modalTarget.showModal();
    }

    close(event) {
        event.preventDefault();

        this.modalTarget.close();
        this.formTarget.reset();
    }
}
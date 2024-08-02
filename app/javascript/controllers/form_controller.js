import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {}

  cpfMask(event) {
    const cpfMask = IMask(event.target, {
      mask: "000.000.000-00",
    });

    cpfMask.updateValue();
  }

  cepMask(event) {
    const cepMask = IMask(event.target, {
      mask: "00000-000",
    });

    cepMask.updateValue();
  }
}

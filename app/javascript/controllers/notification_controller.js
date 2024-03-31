import { Controller } from "@hotwired/stimulus"
import consumer from "channels/consumer"

export default class extends Controller {
  connect() {
    this.sub = this.createActionCableChannel();
  }

  createActionCableChannel() {
    return consumer.subscriptions.create("NotificationChannel", {
      connected() {
        console.log("Connected NotificationChannel")
      },

      disconnected() {
        console.log("Disconnected NotificationChannel")
      },

      received(data) {
        const element = document.getElementById("notification");
        const html = `
          <div id="notification-toast" class="toast-container position-absolute" style="right: 5%; top: 15%">
            <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
              <div class="toast-header">
                <p class="m-0">
                  <span class="fw-bolder">${data.creator}</span> shared a new video
                </p>
              </div>
              <div class="toast-body">
                <p class="text-danger">${data.title}</p>
              </div>
            </div>
          </div>
        `;
        element.insertAdjacentHTML("afterbegin", html);
        const toast = new bootstrap.Toast(document.getElementById('liveToast'));
        toast.show();
      }
    });
  }
}

App.reminders = App.cable.subscriptions.create("RemindersChannel", {
    connected: function() {
        // Called when the subscription is ready for use on the server
    },
    
    disconnected: function() {
        // Called when the subscription has been terminated by the server
    },
    
    received: function(data) {
        this.renderModal(`Reminder for ${data.time}`, data.html_description);
    },
    
    renderModal: function(title, body) {
        const modal      = document.querySelector('#reminder-modal');
        const modalTitle = modal.querySelector('.modal-title');
        const modalBody  = modal.querySelector('.modal-body');

        modalTitle.textContent = title;
        modalBody.innerHTML = body;
        $(modal).modal({ focus: true });
    }
});

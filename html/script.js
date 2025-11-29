const { createApp } = Vue;

createApp({
    data() {
        return {
            jobs: [],
            texts: {
                jobCenterTitle: 'Job Center',
                closeButton: '✖',
                applyButton: 'Sign Up',
                applicationSubmittedTitle: 'Application Submitted!',
                applicationSubmittedMessage: 'You have signed for the position of {job} with a pay of {pay}.'
            },
            isVisible: false
        };
    },
    mounted() {
        window.addEventListener('message', this.handleMessage);
        document.addEventListener('keydown', this.handleEscape);
    },
    beforeUnmount() {
        window.removeEventListener('message', this.handleMessage);
        document.removeEventListener('keydown', this.handleEscape);
    },
    methods: {
        handleMessage(event) {
            const data = event.data;
            if (data.action === 'SHOW_UI') {
                this.jobs = data.jobs || [];
                this.texts = { ...this.texts, ...data.texts };
                this.isVisible = true;
            }
        },
        handleEscape(event) {
            if (event.key === 'Escape' && this.isVisible) {
                this.closeUI();
            }
        },
        closeUI() {
            this.fetchNui('CLOSE_UI');
            this.isVisible = false;
        },
        applyForJob(job) {
            this.fetchNui('APPLY_JOB', { name: job.name });
            
            let message = this.texts.applicationSubmittedMessage;
            message = message.replace('%s', job.label);
            message = message.replace('%s', job.pay);
            
            toastr.success(message, this.texts.applicationSubmittedTitle, {
                positionClass: 'toast-top-right',
                timeOut: 3000,
                closeButton: true,
                progressBar: true,
                showMethod: 'fadeIn',
                hideMethod: 'fadeOut',
                showDuration: 300,
                hideDuration: 1000
            });
        },
        fetchNui(eventName, data = {}) {
            return fetch(`https://${GetParentResourceName()}/${eventName}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            });
        }
    }
}).mount('#app');
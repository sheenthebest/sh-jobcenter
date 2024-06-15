document.addEventListener('DOMContentLoaded', function () {
    const jobListContainer = document.getElementById('job-list');
    document.getElementById('job-center-title').innerText = texts.jobCenterTitle;
    document.getElementById('close-button').innerText = texts.closeButton;

    jobList.forEach(job => {
        const jobItem = document.createElement('div');
        jobItem.classList.add('job-item');

        jobItem.innerHTML = `
            <img src="${job.image}" alt="${job.label}">
            <div class="job-title">${job.label} ${job.recommended ? '<span class="recommended">★</span>' : ''}</div>
            <div class="job-pay">Pay ${job.pay}</div>
            <div class="job-description">
                <p>${job.description}</p>
            </div>
            <div class="job-tags">
                ${job.tags.map(tag => `<span class="job-tag">${tag}</span>`).join('')}
            </div>
            <button class="apply-button" onclick="applyForJob(${job.id}, '${job.label}', '${job.pay}', '${job.name}', this)">${texts.applyButton}</button>
        `;

        jobListContainer.appendChild(jobItem);
    });

    document.getElementById('close-button').addEventListener('click', function() {
        const jobCenter = document.getElementById('job-center');
        jobCenter.style.animation = 'fadeOut 0.5s ease-in-out forwards';
        setTimeout(() => {
            $.post(`https://${GetParentResourceName()}/CLOSE_UI`);
            document.querySelector('body').style.display = 'none';
            jobCenter.style.display = 'none';
        }, 500);
    });

    window.addEventListener("message", (event) => {
        const data = event.data;
        const action = data.action;
        if (action === "SHOW_UI") {
            const body = document.querySelector('body');
            body.style.display = 'flex';
            const jobCenter = document.getElementById('job-center');
            jobCenter.style.display = 'block';
            jobCenter.style.animation = 'fadeIn 0.5s ease-in-out forwards';
        }
    });

    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            $.post(`https://${GetParentResourceName()}/CLOSE_UI`);
            const jobCenter = document.getElementById('job-center');
            jobCenter.style.animation = 'fadeOut 0.5s ease-in-out forwards';
            setTimeout(() => {
                $.post(`https://${GetParentResourceName()}/CLOSE_UI`);
                document.querySelector('body').style.display = 'none';
                jobCenter.style.display = 'none';
            }, 500);
        }
    });

    // close ui on start
    document.querySelector('body').style.display = 'none';
});

function applyForJob(jobId, label, jobPay, name, button) {
    $.post(`https://${GetParentResourceName()}/APPLY_JOB`, JSON.stringify({ name: name }));

    toastr.success(texts.applicationSubmittedMessage(label, jobPay), texts.applicationSubmittedTitle, {
        positionClass: 'toast-top-right',
        timeOut: 3000,
        closeButton: true,
        progressBar: true,
        showMethod: 'fadeIn',
        hideMethod: 'fadeOut',
        showDuration: 300,
        hideDuration: 1000
    });
    button.classList.add('applied');
    setTimeout(() => {
        button.classList.remove('applied');
    }, 2000);
}

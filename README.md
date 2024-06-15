# Job Center UI for FiveM

This project provides a customizable Job Center UI for FiveM, allowing players to choose various job roles within the game.

## Showcase
![Screenshot](https://github.com/sheenthebest/sh-jobcenter/blob/main/html/imgs/showcase.jpg?raw=true)

## Features

- Display multiple job roles with descriptions, images, and tags.
- Scrollable job descriptions.
- Highlight recommended jobs.
- Notification system for job applications using Toastr.
- Smooth animations for UI transitions.

## Getting Started

### Prerequisites

- A FiveM server.
- Basic knowledge of HTML, CSS, and JavaScript.

### Installation
- Download and extract the project files to your FiveM resources directory.
- Add the resource to your server configuration file (`server.cfg`) with the line:
     ```
     ensure sh-jobcenter
     ```

### Configuration
- Open `config.lua` to edit accessible locations.
- Update `config.js` to customize job details and UI text.

```javascript
const jobList = [
    {
        id: 1,
        name: 'reporter',
        label: 'Reporter',
        pay: '$150',
        description: `
            <strong>Reporters</strong> gather and analyze information, conduct interviews, and write news stories. 
            Topics include politics, business, sports, and entertainment. Strong communication skills are essential.
        `,
        image: 'imgs/reporter.png',
        tags: ['Media', 'Communication', 'Writing'],
        recommended: true
    },
    // Add more jobs as needed...
];

const texts = {
    jobCenterTitle: 'Job Center',
    closeButton: '✖',
    applyButton: 'Sign Up',
    applicationSubmittedTitle: 'Application Submitted!',
    applicationSubmittedMessage: (jobName, jobPay) => `You have signed for the position of ${jobName} with a pay of ${jobPay}$.`
};

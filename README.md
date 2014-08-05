# Tracker-Pull

Tracker-Pull is a simple Sinatra app for integrating GitHub pull-requests and Pivotal Tracker stories.

## Current Functionality

Currently Tracker-Pull will look for a Pivotal Tracker story id in the branch name. 
It will then add a comment on the Pivotal Tracker story linking to the GitHub pull request 
and a comment on the GitHub pull request linking to the Pivotal Tracker story.

## Setup 

1. Find your Pivotal Tracker token at the bottom of your [profile page](https://www.pivotaltracker.com/profile) 
2. [Create a new GitHub OAuth token](https://help.github.com/articles/creating-an-access-token-for-command-line-use)
3. Create a new heroku app
4. Set the following heroku [config vars](https://devcenter.heroku.com/articles/config-vars) 
    1. TRACKER_TOKEN
    2. GITHUB_TOKEN
5. [Clone the Tracker-Pull repo](http://git-scm.com/book/en/Git-Basics-Getting-a-Git-Repository#Cloning-an-Existing-Repository)
6. [Deploy Tracker-Pull to Heroku](https://devcenter.heroku.com/articles/git)
7. [Create a webhook in GitHub](https://developer.github.com/webhooks/creating/) using the following configuration
    1. Payload URL = your-heroku-app-name.herokuapp.com/payload
    2. Content Type = application/json
    3. Leave the secret field blank
    4. Choose "Let me select individual events"
    5. Choose "Pull Request" events


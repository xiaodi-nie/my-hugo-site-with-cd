---
title: "Continuous Deployment of Flask Application on GCP"
date: 2020-04-20T22:03:42Z
draft: false
description: "Steps and notes to build a continuous deployment workflow of Flask application on Google Cloud Platform"
draft: false
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
authorEmoji: 🐹
tags:
- cloud computing
- google cloud
- continuous deployment
categories:
- Coding
---


# Continuous Deployment of Flask Application on GCP
This project implements continuous deployment using Google's Cloud Build service. A simple flask application will be deployed to App Engine everytime a new push happens in this github repo. It is done through Cloud Source Repositories and they are private Git repositories hosted on Google Cloud. These repositories let you develop and deploy an app or service in a space that provides collaboration and version control for your code.

A live demo of the website can be found [here](https://flash-time-266701.appspot.com)

Demo video: [Cloud Analysis Project 1: Continuous Deployment of Flask App on GCP](https://youtu.be/2WgnXvJMDI4)

## Create new Git repo
First we need a new github repo. We will later sync Cloud Source Repositories to this repo to enable continuous build and deploy.

## Clone repo on GCP cloud shell
1. Go to GCP console and create a new project
2. Activate cloud shell
3. Verify that project is working 

```gcloud projects describe $GOOGLE_CLOUD_PROJECT```

* If project is not specified, use ```gcloud config set project [PROJECT_ID]``` You can find your project id on the console home page.

* The describe command should return something like this if everything is working ok:
```
createTime: '2020-01-30T01:31:51.088Z'
lifecycleState: ACTIVE
name: My First Project
projectId: flash-time-266701
projectNumber: '433160118539'
```
* Initialize your App Engine app with your project and choose its region:
```
gcloud app create --project=[YOUR_PROJECT_ID]
```

* When prompted, select the region where you want your App Engine application located. Go ahead and choose us-central.

* Install prerequisites
[Install and download Git ](https://git-scm.com/)
Install app engine extensions for python3.7
```
gcloud components install app-engine-python
```
4. Create ssh key on cloud shell

```ssh-keygen -t rsa```

* Then click 'enter' through the prompts to skip setting password. You can find your ssh key here
```
Your public key has been saved in /home/niexiaodi_1970/.ssh/id_rsa.pub.
```
* Print the key out
```
cat /home/niexiaodi_1970/.ssh/id_rsa.pub
```
* and add the output to github. You can find this in `Settings - SSH and GPG keys - New SSH Key`
Now clone the github repo to our cloud shell
```
git clone [YOUR_GITHUB_SSH_CLONE_URL]
```
* Then cd into the repo

5.Activate editor for cloud shell

* Click the little pen button to the left of the cloud shell button

## Create code files

1. Inside the repo folder:
```
touch app.yaml cloudbuild.yaml Makefile requirements.txt main.py
```
2. Use editor to add code to files:

**app.yaml**
```
runtime: python37
```
**Makefile**
```
install:
	pip install -r requirements.txt
```
**requirements.txt**
```
Flask==1.1.1
pandas==0.24.2
```
**main.py**
```python
from flask import Flask
from flask import jsonify
from pandas import pandas as pd


# If `entrypoint` is not defined in app.yaml, App Engine will look for an app
# called `app` in `main.py`.
app = Flask(__name__)


@app.route('/')
def hello():
    """Return a friendly HTTP greeting."""
    return 'Hello Fellas continuous deployment on GCP rox yeeeeeheee!'

@app.route('/name/<value>')
def name(value):
    val = {"value": value}
    return jsonify(val)

@app.route('/html')
def html():
    """Returns some custom HTML"""
    return """
    <title>This is a Hello World World Page</title>
    <p>Hello</p>
    <p><b>World</b></p>
    """

@app.route('/pandas')
def pandas_sugar():
    df = pd.read_csv("https://raw.githubusercontent.com/noahgift/sugar/master/data/education_sugar_cdc_2003.csv")
    return jsonify(df.to_dict())

if __name__ == '__main__':
    # This is used when running locally only. When deploying to Google App
    # Engine, a webserver process such as Gunicorn will serve the app. This
    # can be configured by adding an `entrypoint` to app.yaml.
    app.run(host='127.0.0.1', port=8080, debug=True)
# [END gae_python37_app]
```
**cloudbuild.yaml**
```
steps:
- name: "gcr.io/cloud-builders/gcloud"
  args: ["app", "deploy"]
timeout: "1600s"
```
3. Test manually

* Create an isolated Python environment in a directory external to your project and activate it:
```
python3 -m venv env
source env/bin/activate
```
* Navigate to your project directory and install dependencies:
```
cd YOUR_PROJECT
make install
```
* Run the application:
```
python main.py
```
* Now in the toolbar, click Web Preview and select Preview on port 8080 to preview the website

4. Deploy manually
```
gcloud app deploy
```
Output should be something like this if everything works out:
```
Updating service [default]...done.
Setting traffic split for service [default]...done.
Deployed service [default] to [https://flash-time-266701.appspot.com]
You can stream logs from the command line by running:
  $ gcloud app logs tail -s default
To view your application in the web browser run:
  $ gcloud app browse
```
We can now use this link to view our flask website.

5. Setup automated deployment on change

* Follow the instructions [here](https://cloud.google.com/source-repositories/docs/quickstart-triggering-builds-with-source-repositories)

* Remember to enable the app engine admin API, and grant App Engine access to the Cloud Build service account.

* Push everything to github, the magic is done by the cloudbuild.yaml file.

* Create a build trigger and when prompted to choose repositories, click `connect new repository` and connect your github repo.
	
> Remember to put `*.md` in the `Ignored files filter (glob) (Optional)` field to prevent automatic build when only markdown files are updated.

* Now you can push something to test if a new build is triggered. You can check the build log from the `History` tab on the Cloud Build console.

## References
* [Quickstart for Python 3 in the App Engine Standard Environment](https://cloud.google.com/appengine/docs/standard/python3/quickstart)
* [Automate App Engine Deployments with Cloud Build](https://cloud.google.com/source-repositories/docs/quickstart-triggering-builds-with-source-repositories)
* [Paas Continuous Delivery with video instructions](https://github.com/noahgift/cloud-data-analysis-at-scale/blob/master/topics/paas-continuous-delivery.md)


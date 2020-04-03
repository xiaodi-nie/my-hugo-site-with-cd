---
title: "Build your own API with Cloud Functions on GCP"
date: 2020-04-03T02:16:03Z
description: "Steps and notes to build an API quickly using Google Cloud Functions"
draft: true
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
authorEmoji: 🐹
tags:
- serverless
- google cloud
categories:
- Coding
---

Cloud Functions on GCP allows developers to build lightweight API quickly that scales instantly. The function can be triggered by event or invoked over HTTP/S.

### Steps

**Create a Cloud Function from GCP console**

- Go to the GCP console and find Cloud Functions, click `Create Function`
- Give it a name, here we'll leave the trigger as `HTTP`
- Tick `Allow unauthenticated invocations` for the API to be public. We set this now for simple testing purposes, if you want your API not to be public, you can untick this box and use IAM to set specific permissions after the function has been created.
- Here we'll use the inline editor to put in the source code. Cloud Functions allows you to use `requirements.txt` to install python packages. Just change the `runtime` to `Python 3.7` and put in the function code and package names

![config1](/images/cloud_function1.png)
![config2](/images/cloud_function2.png)
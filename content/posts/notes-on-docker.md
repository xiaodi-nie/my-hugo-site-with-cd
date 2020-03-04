---
title: "Cloud Analysis course discussion notes - Docker"
date: 2020-02-27T20:22:43Z
draft: true
description: "course notes on docker"
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
math: true
authorEmoji: 🐹
tags:
- containers
- docker
categories:
- Coding
- Course notes
---

### Docker's two modes
**Interactive**

usage example: run jupyter, add python2.7 to test

**Background**

usage example: run as server(running forever), website


Docker is basically a better version of `virtualenv`, where you have an seperate environment (and a set of package versions) for every container

### Docker workflow example
Here are the steps I did to containerize a simple flask app.
1. Create Github repo
2. Create ssh keys and upload to Github
3. Git clone
4. Create a local python virtual environment and source: ```python 3 -m venv ~/.dockerproj && source ~/.dockerproj/bin/activate```
5. Create files:

**Dockerfile**
```Dockerfile
FROM python:3.7.3-stretch

# Working Directory
WORKDIR /app

# Copy source code to working directory
COPY . app.py /app/

# Install packages from requirements.txt
# hadolint ignore=DL3013
RUN pip install --upgrade pip &&\
    pip install --trusted-host pypi.python.org -r requirements.txt
```


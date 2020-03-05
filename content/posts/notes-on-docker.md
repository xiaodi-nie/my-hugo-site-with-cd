---
title: "Cloud Analysis course discussion notes - Docker"
date: 2020-02-27T20:22:43Z
draft: false
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

#Expose port 8080 on the docker image
#to make the flask website accessible
EXPOSE 8080

# Run app.py at container launch
CMD ["python", "app.py"]
```

**requirements.txt**
```
pylint
flask
pandas
```

**Makefile**
```Makefile
setup:
	python3 -m venv ~/.dockerproj

install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

validate-circleci:
	# See https://circleci.com/docs/2.0/local-cli/#processing-a-config
	circleci config process .circleci/config.yml

lint:
	hadolint Dockerfile 
	pylint --disable=R,C,W1203 app.py

all: install lint test
```

**app.py**
```python
#!/usr/bin/env python
from flask import Flask
from flask import jsonify
from pandas import pandas as pd


# If `entrypoint` is not defined in app.yaml, App Engine will look for an app
# called `app` in `main.py`.
app = Flask(__name__)


@app.route('/greeting')
def hello():
    """Return a friendly HTTP greeting."""
    return 'Hello Fellas continuous deployment on GCP rox yeeeeeheee!'

@app.route('/name/<value>')
def name(value):
    val = {"value": value}
    return jsonify(val)

@app.route('/')
def html():
    """Returns some custom HTML"""
    return """
    <title>This is a Hello World World Page</title>
    <h3>Hello</h3>
    <br>
    <p><b>This is a simple flask web page</b></p>
    <p>Wrapped inside a Docker container and running on cloud9</p>
    """

@app.route('/pandas')
def pandas_sugar():
    df = pd.read_csv("https://raw.githubusercontent.com/noahgift/sugar/master/data/education_sugar_cdc_2003.csv")
    return jsonify(df.to_dict())


if __name__ == '__main__':
    # bind to 0.0.0.0 so that the outside world can access the docker container
    app.run(host='0.0.0.0', port=8080, debug=True)

```

6. configure CircleCI

    Create a folder named ```.circleci```, and put ```config.yml``` inside.

**config.yml**
```yml
# Python CircleCI 2.0 configuration file
#
# Check https://circleci.com/docs/2.0/language-python/ for more details
#
version: 2
jobs:
  build:
    docker:
    # Use the same Docker base as the project
      - image: python:3.7.3-stretch

    working_directory: ~/repo

    steps:
      - checkout

      # Download and cache dependencies
      - restore_cache:
          keys:
            - v1-dependencies-
            # fallback to using the latest cache if no exact match is found
            - v1-dependencies-

      - run:
          name: install dependencies
          command: |
            python3 -m venv venv
            . venv/bin/activate
            make install
            # Install hadolint
            wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64 &&\
                chmod +x /bin/hadolint
      - save_cache:
          paths:
            - ./venv
          key: v1-dependencies-

      # run lint!
      - run:
          name: run lint
          command: |
            . venv/bin/activate
            make lint
```
    
Go to your CircleCI page and setup the project.


7. Build ang tag the image

    ```cd``` into the directory containing ```Dockerfile``` and run:
    
    ```docker build --tag=<your_tag_name> .``` 
    
    replace with your own tag name
    
8. Run container and test the app

    ```docker run -p 8080:8080 <your_tag_name>```
    
    this will map port 8080 on the container to port 8080 on the hosting machine.
    
    My container was running on an EC2 instance so I would have to allow port 8080 on the inbound rule of the security group controlling the instance. Then I can use the public DNS of that instance to access the flask website with a browser.
    

9. Setup DockerHub 

    Sign in to DockerHub and **create a new repository**, note down the repo path, which would look someting like this: ```xnie1970/simple_python_from_cloud9```
    
    go back and run:
    
    ```docker image tag <your_tag_name> <your_docker_path>```
    
    ```docker image push <your_docker_path> ```
    
    the first time you do these you have to login using DockerHub credentials.
    
Alternatively you can write a script to do the pushing:
    
**push_docker.sh**
```bash
#!/usr/bin/env bash
# This tags and uploads an image to Docker Hub

#Assumes this is built
#docker build --tag=app .


dockerpath="xnie1970/simple_python_from_cloud9"

# Authenticate & Tag
echo "Docker ID and Image: $dockerpath"
docker login &&\
    docker image tag app $dockerpath
#after the first time you don't need to enter your credentials again

# Push Image
docker image push $dockerpath
```
don't forget to ```chmod +x push-docker.sh``` before running the script.

10. Test pulling image from DockerHub

    ```
    docker pull xnie1970/simple_python_from_cloud9
    docker run -p 8080:8080 xnie1970/simple_python_from_cloud9:latest
    ```
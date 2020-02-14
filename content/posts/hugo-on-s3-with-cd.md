---
title: "Hosting Hugo Website on AWS S3 with Continuous Deployment"
date: 2020-02-14T18:50:12Z
description: "Steps and notes to build a continuous deployment workflow of Hugo website with the help of AWS S3 and CodeBuild"
draft: false
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
authorEmoji: 🐹
tags:
- cloud computing
- hugo
- aws
- continuous deployment
categories:
- Coding
---

This is the basic workflow of this blog and list of steps to continuous deployment. It is also a course note and the majority of the materials came from my professor's [post here](https://noahgift.github.io/cloud-data-analysis-at-scale/topics/continuous-delivery)

### Set up Hugo workflow using AWS Cloud9 and Github

First we are going to setup a cloud9 environment as the working directory of the whole thing. 
Cloud9 provides a quick and easy linux environment/web-based editor hosted on an EC2 instance that would be automatically stopped after 30m of unuse.
It's quite cost effective and convenient especially for windows users.

- ##### Launch an AWS Cloud9 Environment

Log into your AWS account and go to the Cloud9 console. Create a new environment with the free tier instance and the default configurations.

- ##### Install Hugo

Use ```wget``` to downlad the latest version of hugo binary. You can find the latest release [here](https://github.com/gohugoio/hugo/releases).

```
wget https://github.com/gohugoio/hugo/releases/download/v<LATEST_VERSION>/hugo_<LATEST_VERSION>_extended_Linux-32bit.tar.gz
```

Note that here we used the **extended** version since we are going to use a theme that depends on the extended version of hugo.

Now unzip and install the hugo binary:
```
tar xzvf hugo_0.64.0_extended_Linux-32bit.tar.gz
mkdir -p ~/bin
mv ~/environment/hugo ~/bin #assuming that you download this into ~/environment
which hugo              #this shows the `path` to hugo and should be '~/bin/hugo'
hugo version            #check that hugo is successfully installed
```
- ##### Create a website

You might have seen a lot of people saying that `hugo` is better and faster than `jekyll`, and part of the reason is that `hugo` is just a `go` binary. 
Because of that, development and deployment is very simple and quick with `hugo`.
Now you can use `hugo new site mywebsite` to create a new site.

Hugo has a wide range of theme selections and in my personal experience the best way to use themes is:
1. Fork theme repo into your github account

This blog used [hugo-theme-zzo](https://github.com/zzossig/hugo-theme-zzo)

2. Add the theme into your website as a submodule

```
cd mywebsite
git submodule add https://github.com/<YOUR_GITHUB_ID>/hugo-theme-zzo themes/zzo
```
3. Make your own changes to the theme and track it into your forked repo
4. Update the main site repo to the latest theme repo version(we will be tackling this later)
5. Add the theme into the config file

```echo 'theme = "zzo"' >> config.toml```

6. ```git pull``` changed and update from the original theme repo if necessary(may need to fix conflict)

Now create a new post:

```hugo new posts/my-first-post.md```

This will create a new markdown file with the created timestamp. You can edit this file with the cloud9 editor.

Note that if you use this command to generate a new post, the `draft` field will be defaulted to `true` which means this file will not be built into html and it will not be visible on the deployed website.

- ##### Run Hugo locally in Cloud9

Here we are going to run `hugo` as a deployment server. To access the port after the server has started, we will need to open up a port on the EC2 security groups.
Just look for the *security group* tab on the EC2 console page, and look for the one with the same name as your current Cloud9 environment:
![security group](/images/cloud9_security_group.png)

Go to the *Inbound* tab, click the *Edit* button and add a new *Custom TCP Rule* with port *8080*.

Now we can go back to Cloud9 and use `curl ipinfo.io` to find out the public ip address. The output should look something like this:
```json
{
  "ip": "54.80.213.10", #this is the address we want
  "hostname": "ec2-54-80-213-10.compute-1.amazonaws.com",
  "city": "Virginia Beach",
  "region": "Virginia",
  "country": "US",
  "loc": "36.8512,-76.1692",
  "org": "AS14618 Amazon.com, Inc.",
  "postal": "23465",
  "timezone": "America/New_York",
  "readme": "https://ipinfo.io/missingauth"
}
```
Run `hugo` with the following options. This will start the server and left it running.

`hugo serve --bind=0.0.0.0 --port=8080 --baseURL=http://<YOUR_PUBLIC_IP_ADDRESS>/`

Open up a new tab in your browser and go to `http://<YOUR_PUBLIC_IP_ADDRESS>:8080/` to preview your site. Cool thing about this is you can edit your markdown file and it will render and reflect the change on the site in real time.

### Host the static site on S3
First follow [this instruction](https://docs.aws.amazon.com/AmazonS3/latest/user-guide/static-website-hosting.html) to set up an S3 bucket for static website hosting.

You should also set a *bucket policy* as below from the *Permissions* tab on your bucket page, with your own bucket name:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::<YOUR_BUCKET_NAME>/*"
            ]
        }
    ]
}
```

- ##### Deploy website manually to S3

Before going fully automatic, it's best to first deploy to your bucket manually and see if everything works out.

Add the following to the existing `config.toml` file(overwrite fields if exists)
```toml
baseURL = "http://<YOUR_BUCKET_NAME>.s3-website-<YOUR_BUCKET_REGION>.amazonaws.com"
title = "<YOUR_TITLE>"
theme = "zzo"

[[deployment.targets]]
# An arbitrary name for this target.
name = "<WHATEVER_NAME>"
URL = "s3://<YOUR_BUCKET_NAME>/?region=<YOUR_BUCKET_REGION>" #your bucket here

```
Now you can deploy using the following commands:
```
hugo
hugo deploy
```
If everything works out you should see something like this:
```bash
ec2-user:~/environment/quickstart (master) $ hugo

                   | EN   
-------------------+------
  Pages            |  34  
  Paginator pages  |   0  
  Non-page files   |   0  
  Static files     | 105  
  Processed images |   0  
  Aliases          |   9  
  Sitemaps         |   1  
  Cleaned          |   0  

Total in 5692 ms
ec2-user:~/environment/quickstart (master) $ hugo deploy
Deploying to target "jan23awsbucket" (s3://jan23-website-hosting/?region=us-east-1)
Identified 1 file(s) to upload, totaling 244 kB, and 0 file(s) to delete.
Success!
```

Now your website should be accessible through the static website hosting endpoint.

### Continuous Delivery with AWS CodeBuild

- ##### Check code into Github

1. Create a new repo and add `.gitignore` with `Go`
2. (Optional) Add `public` to `.gitignore` to skip pushing all built html files to repo
3. Create a Makefile to remove the public folder:
```Makefile
clean:
	echo "deleting generated html..."
	rm -rf public
```
Now run `make clean` to remove all the generated html files to prevent them from being uploaded to version control. 

4. Add repo as a remote and push code
```
git remote add origin git@github.com:<github_username>/my_hugo_site.git
git status
git add *
git pull --allow-unrelated-histories origin master
git branch --set-upstream-to=origin/master
git push
```
- ##### Setup project on AWS CodeBuild

Go to AWS CodeBuild and create a new project in the *same region as your S3 bucket*

Note in the **Source** section, use **OAuth** to login to Github and choose **Repository in my Github Account**. In **Additional Configuration**, choose *git clone depth = 1*, tick *Use Git submodules* and *Report build statuses to source provider when your builds start and finish*

In the **Webhook** section, tick *Rebuild every time a code change is pushed to this repository*.

The **Environment** section should look something like this:
![codebuild environment](/images/codebuild.png)

Now go to the *Service role* page from the project detail page, and attach an **AdministratorAccess** policy to that role.

Ok, one last step. Go back to Cloud9 and add a `buildspec.yml` file to tell AWS what you want to do with the automatic build:
```yaml
version: 0.2

environment_variables:
  plaintext:
    HUGO_VERSION: "0.64.0"
    
phases:
  install:
    runtime-versions:
      docker: 18
    commands:                                                                 
      - cd /tmp
      - wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_extended_Linux-64bit.tar.gz
      - tar -xzf hugo_${HUGO_VERSION}_extended_Linux-64bit.tar.gz
      - mv hugo /usr/bin/hugo
      - cd - 
      - rm -rf /tmp/*
  build:
    commands:
      - rm -rf public
      - hugo
      - aws s3 sync public/ s3://<YOUR_BUCKET_NAME>/ --region <YOUR_BUCKET_REGION> --delete
  post_build:
    commands:
      - echo Build completed on `date`
```

DONE! Now you can push something to your github repo and check out the new build that pops up on the build history page of your CodeBuild project.




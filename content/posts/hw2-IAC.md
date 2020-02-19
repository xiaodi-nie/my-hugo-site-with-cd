---
title: "Cloud Analysis course note - IaC and cloud service model"
date: 2020-02-19T22:34:03Z
draft: false
description: "Cloud Analysis course discussion note on IAC, SaaS, PaaS, IaaS, MaaS and Serverless"
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
authorEmoji: 🐹
tags:
- cloud computing
- IaC
categories:
- Coding
- Course notes
---

### What is IAC and what problem does it solve?

IAC stands for Infrastructure as Code. is a method to provision and manage IT infrastructure through the use of source code, rather than through standard operating procedures and manual processes.

You’re basically treating your servers, databases, networks, and other infrastructure like software. And this code can help you configure and deploy these infrastructure components quickly and consistently.

IaC helps you automate the infrastructure deployment process in a repeatable, consistent manner, which has many benefits.

With IaC, deployment doesn’t always have to all fall on DevOps’ shoulders. Developers today can write not only application code, but also the infrastructure to run applications. And companies today can even integrate infrastructure code into the software development system to vastly increase development efficiency.

IaC let machines do all the work to set up cloud environment and manage resources that you need, which makes it faster and more efficient than humans would do.

It also makes continuously testing systems and processes possible for infrastructure configuration. In modern software systems, you can build a "deployment pipeline" for infrastructure code, which allows you to practice continuous delivery processes for infrastructure changes.

If infrastructure is being turned into code, the biggest perk should be version control. With version control it would be easier to roll back to a working configuration if anything goes wrong, and the environment would be easier to track and maintain, errors can be found and fixed more quickly.

### How should a company decide on what level of cloud abstraction to use

#### SaaS
Software as a Service. SaaS utilizes the internet to deliver applications, which are managed by a third-party vendor, to its users. A majority of SaaS applications run directly through your web browser, which means they do not require any downloads or installations on the client side. Use it if you are after features that you don’t want to build yourself and that can significantly improve your product

#### PaaS
Platform as a Service. Example: Google Kubernetes Engine, Azure Container Service. PaaS delivers a framework for developers that they can build upon and use to create customized applications.Use it if you want to just focus on the application code without having to worry about infrastructure.

#### IaaS
Infrastructure as a Service. Example: AWS EC2, AWS VPC, AWS ELB. IaaS is fully self-service for accessing and monitoring computers, networking, storage, and other services. IaaS allows businesses to purchase resources on-demand and as-needed instead of having to buy hardware outright. Use it if you want granular control over your product’s infrastructure.

#### MaaS
Metal(Machine) as a Service. Use if you want just the machine and the freedom to install OS and do configurations yourself. This is particularly useful for multi-nodes applications like Hadoop clusters.

#### Serverless
It’s basically FaaS(Function as a Service, like AWS Lambda)+BaaS(Backend as a Service, like AWS DynamoDB, Google App Engine). It’s similar to Paas, use it if you want to focus on code, but Serverless provides even more deployment ease and even less configuration.
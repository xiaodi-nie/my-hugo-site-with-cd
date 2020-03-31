---
title: "Cloud Analysis Course Notes - Serverless Architecture"
date: 2020-03-31T23:32:58Z
draft: false
description: "course notes on serverless architectures."
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
math: true
authorEmoji: 🐹
tags:
- serverless
- aws
categories:
- Coding
- Course notes
---

##	What are the tradeoffs with a serverless architecture?

There are many **advantages** of using a serverless architecture, and to name a few:

**Lower operation cost**: You don’t have to set up infrastructure and can pay for only what you use.

**Less time to market**: The serverless architecture style motivates to use existing or third party services. Because functions are small and have a clear responsibility the likelihood for reusing existing functions increases. The platforms to operate serverless architectures takes care of all the operating stuff. The developers just have to upload the code and get direct feedback how the code behave in production. Thus overall the developing time can be shortened comparing to other architecture and the product can make it to market much faster.

**Elasticity**: Going serverless means the system has the built-in ability of scaling up and down automatically according to the load need


However, there are also a number of **trade-offs** to consider when going the serverless route:

**Systemic complexity**: serverless architecture tend to produce "nanoservices" and requires more experienced engineers to get it right. By definition “nanoservice” is an antipattern where a service is too fine-grained. A nanoservice is a service whose overhead (communications, maintenance, and so on) outweighs its utility.

**Lock-in**: To run a system on one vendor you must use very specific services provided by the vendor (for example to compliment Amazon Lambda you have to use Amazon API Gateway, DynamoDB, S3, etc.). Once you developed a complex system on top of these services you are cursed to stick with them, no matter how often they decide to increase their prices. And migration to another lower-priced vendor may have higher overhead than your actual savings. 

**Resource limitations**: Functions have limitations in regards to memory allocation, timeout, payload sizes, deployment sizes, concurrent executions, etc. 

**Development difficulties**: integration test and debugging can be difficult. You may not have control over all the other services surrounding your function, and debugging from vendor platform may not be so convenient.

## What are the advantages of developing with Cloud9?

Since AWS Cloud 9 is cloud-based, users are encouraged to have a flexible and efficient development environment. Developers can **run, write, and debug apps** through a **web browser** that frees them from the usual local IDE constraints.

With AWS Cloud9’s **collaboration features**, teams can work and code together online and in real time. Users can share their own development workplace with other teammates through a few simple clicks and even do a pair-program while working.

Cloud9 **pre-configures** the user’s development environment with all the essential **libraries, plug-ins, and SDKs** it needs for a serverless development. And it also provides an environment for debugging the AWS Lambda functions and local testing.

Moreover, AWS Cloud9 IDE has a **terminal with sudo** privileges connected to the managed Amazon EC2 instance that hosts the whole development environment. The setup also has a pre-authenticated **AWS Command Line Interface**. With these features, users can access AWS services and run commands quicker.

###References

https://medium.com/@pablo.iorio/serverless-architectures-i-iii-design-and-technical-trade-offs-8ca5d637f98e

https://specify.io/concepts/serverless-architecture

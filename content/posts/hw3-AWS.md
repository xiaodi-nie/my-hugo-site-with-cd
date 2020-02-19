---
title: "Hw3 AWS"
date: 2020-02-19T23:05:40Z
draft: false
description: "Cloud Analysis course discussion note on AWS network security strategy and spot instance"
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
authorEmoji: 🐹
tags:
- cloud computing
- aws
categories:
- Coding
- Course notes
---

### What are the different layers of network security on AWS and what unique problems do each solve?
According to the AWS security white paper, AWS has the following layers of network security:
- Secure Network Architecture

There are network devices like firewalls at the edge of the aws network to closely monitor and guard the information flow in both ways. ACLs, or Access Control List are in place to manage the traffic flow.
- Secure Access Points

AWS has a limited number of access points(API endpoints) to the cloud to monitor more comprehensively of inbound and outbound traffic. They allow HTTPS access which we can use to establish secure connection with our storage or compute instances within AWS.
- Transmission Protection

SSL protocal(Secure Sockets Layer) can be utilized to connect to AWS access point and prevent eavesdropping, tampering and message forgery. In addition, Amazon Virtual Private Cloud (VPC) offers a private subnet within the AWS cloud, and VPN can also be used to establish an encrypted tunnel between the Amazon VPC and your data center.
- Amazon Corporate Segregation

The AWS Production network is segregated from the Amazon Corporate network. Only approved personnel, developers and administrators, can access the AWS corporate network through a bastion host that restricts access to cloud components which requires a SSH key, and all activities will be logged for security review.
- Fault-Tolerant Design

Amazon’s infrastructure has a high level of availability. Data centers are built in clusters in various global regions. If failure happens, customer data will be automatically moved away from the affected area. We can also place instances and store data within multiple geographic regions/availability zones to provide more physical separation and better availability.
- Network Monitoring and Protection

There are a wide variety of automated monitoring systems to detect unusual or unauthorized activities and conditions at incoming and outgoing communication points. Alarms are configured to notify operations and management personnel when thresholds are crossed on key operational metrics. On top of that, there are always people on call to handle those alarms or issues regarding operation. Ticketing system is in place to propagate severe/emergence incident to upper management. There are also documentation of aid and help personnel to handle incidents.

### What problem do AWS Spot instances solve and how could you use them in your projects?

One of the problems with the on-demand business model (like normal EC2 instances) is that at any given time, there are likely to be compute resources that are not being utilized. These resources represent hardware capacity that AWS has paid for but are sitting idle.  Rather than allowing these computing resources to go to waste, AWS offers them at a substantially discounted rate, with the understanding that if someone needs those resources for running a normal EC2 instance, that instance will take priority over spot instances and the spot instance may be interrupted at any time. 

Those who wish to use spot resources simply tell AWS how much they are willing to pay per hour for those resources. Spot instances will continue to run until the cost of the resource meets or exceeds the agreed-upon price. Of course, subscribers are also free to stop or terminate spot instances themselves. 

Since spot instances are subject to sudden interruptions, they should not be used on situations where your applications need to be up and running at all times. 

However, in our project, if we want to do an experiment or prototype, anything temporary, we can request a spot instance and utilize large computational power at a much lower price.

---
title: "Kubernetes basics"
date: 2020-02-12T00:51:51Z
description: Kubernetes and its orchestration basics
draft: false
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
authorEmoji: 🐹
tags:
- cloud computing
- containers
categories:
- Coding
- Course notes
---

This is a course note and the majority of the meterials came from [this qwiklab](https://www.qwiklabs.com/focuses/557?parent=catalog)

## Overview

Google Kubernetes Engine (GKE) provides a managed environment for deploying, managing, and scaling your containerized applications using Google infrastructure. The Kubernetes Engine environment consists of multiple machines (specifically Google Compute Engine instances) grouped together to form a container cluster.

Kubernetes Engine clusters are powered by the Kubernetes open source cluster management system. Kubernetes provides the mechanisms through which you interact with your container cluster. You use Kubernetes commands and resources to deploy and manage your applications, perform administration tasks and set policies, and monitor the health of your deployed workloads.

## Key components and concepts
### Pods
![kubernetes pods](/images/pods.jpg)
Pods represent and hold a collection of one or more containers. Generally, if you have multiple containers with a hard dependency on each other, you package the containers inside a single pod.

Pods also have volumes attached to them and containers within a pod can share this attached volume through a shared namespace and communicate with each other.

One pod had one shared network namespace which means there's one ip address per pod.

### Services
![kubernetes services](/images/services.jpg)
Services provide stable endpoints for Pods. They are there to help you communicate with a set of pods, since pods don't tend to be persistent and they sometimes would stop or restart due to reasons like failed liveness or readiness checks, and that would result in different ip addresses.

Services used labels to point to pods. So all you have to do to add endpoints to a service is giving a label to each pod inside and the service will pick them up and expose them.

There are three types of services:
- ClusterIP (internal) -- the default type means that this Service is only visible inside of the cluster
- NodePort -- gives each node in the cluster an externally accessible IP
- LoadBalancer -- adds a load balancer from the cloud provider which forwards traffic from the service to Nodes within it.

### Deployments
![kubernetes deployments](/images/deployments.jpg)
Deployments are there to make sure that there are always that amount of pods(replicas) that you want there to be. Deployments use Replica Sets to manage starting and stopping the Pods.

Another cool thing about deployments is that it can recreate and start pods on another node automatically if the node that some pods are residing suddenly failed, thus make the pods inside highly available.

## kubectl commands
List of commands and example usage can be found on the above qwiklab.
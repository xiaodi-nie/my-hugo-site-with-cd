---
title: "Cloud Analysis course notes - Containers"
date: 2020-02-19T23:36:27Z
draft: false
description: "Cloud Analysis course discussion note on containers"
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

### What are containers?

The concept of containers is similar to that of virtual machines. The differentiating factor is that VMs virtualize at the hardware level and containers virtualize at the operating system level. The containerization approach creates a more lightweight and flexible environment by allowing applications to share an operating system while maintaining their own executables, code, libraries, tools, and configuration files. 

A container consists of an entire runtime environment: an application, plus all its dependencies, libraries and other binaries, and configuration files needed to run it, bundled into one package. By containerizing the application platform and its dependencies, differences in OS distributions and underlying infrastructure are abstracted away.

### What problem do containers solve?

Let’s look at this problem by comparing containers with VMs. Comparing to VMs, containers offers the following benefits:
- Lightweight

A container may be only tens of megabytes in size, whereas a virtual machine with its own entire operating system may be several gigabytes in size. Because of this, a single server can host far more containers than virtual machines.
- Just-in-time

Virtual machines may take several minutes to boot up their operating systems and begin running the applications they host, while containerized applications can be started almost instantly. That means containers can be instantiated in a "just in time" fashion when they are needed and can disappear when they are no longer required, freeing up resources on their hosts.
- Modularity

Rather than run an entire complex application inside a single container, the application can be split in to modules (such as the database, the application front end, and so on). This is the so-called microservices approach.  Applications built in this way are easier to manage because each module is relatively simple, and changes can be made to modules without having to rebuild the entire application.
- Scalable

Since they have all of the above advantages, containers can be easily scaled up. You can basically run 1000 environments at the same time at a click of your fingers.

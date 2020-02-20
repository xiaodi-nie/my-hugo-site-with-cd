---
title: "Cloud Analysis course notes - CAP Theorem and Amdahl's Law"
date: 2020-02-20T02:08:02Z
draft: false
description: "Cloud Analysis course discussion note on CAP Theorem and Amdahl's Law, and their relations with machine learning projects"
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
math: true
authorEmoji: 🐹
tags:
- cloud computing
- machine learning
categories:
- Coding
- Course notes
---

### How does the CAP Theorem play a role in designing for the cloud?
The CAP Theorem says that for a distributed system, you can only have 2 of the 3 things: Consistency, Availability and Partition Tolerance. 

Consistency means that only have one copy of up-to-date data, and that all clients see the same data at the same time, no matter which node they connect to. For this to happen, whenever data is written to one node, it must be instantly forwarded or replicated to all the other nodes in the system before the write is deemed ‘successful.’ 

Availability means data is always available for requests from client even when one or more nodes are down. Another way to state this—all working nodes in the distributed system return a valid response for any request, without exception. 

A partition is basically a network break, or a communication delay/lost between nodes within a distributed system. Partition Tolerance is a system’s ability to still work despite any number of network breakdowns between the nodes. 

Any cloud system is a distributed system, so to design a cloud system we always have to have CAP theorem in mind. Of course, if no partition exists, one system can have both consistency and availability, but there’s always going to be times when things go wrong, so we have to make a choice between C and A.  what’s the ultimate design goal in a distributed system for maximum data consistency and 100% availability – it’s design for failure.

### What are the implications of Amdahl’s law for Machine Learning projects?
Amdahl’s law gives the following formula to measure the speedup of running sub-tasks in parallel (over different processors) versus running them sequentially (on a single processor): 

$$ S_L (s) = \cfrac{1}{(1-p) + \cfrac{p}{s}} $$

where s is the speedup of the part of the task that benefits from improved system resources, and p is the proportion of execution time that the part benefiting from improved resources originally occupied(parallel portion). So the theoretical time benefit from doing things parallel is largely dependent on how much of the program is made parallel, which is p. 

Even you can achieve perfect parallelism and scale up the program to match the theoretical estimation, the more cores you have, the less it’s going to improve the performance. There’s always overhead with parallelism at the hardware level(additional computer cycles required to divide tasks into subtasks and compile results after). It’s going to grow the more you parallelize, and it also applies for parallelism in a cloud environment. 

In conclusion, even though it’s tempting to parallelize large data set in machine learning project, you should always keep in mind that parallelism wouldn’t necessarily lead to performance improvement.

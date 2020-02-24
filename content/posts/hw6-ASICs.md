---
title: "Cloud Analysis course discussion note - ASICs"
date: 2020-02-24T21:25:08Z
draft: false
description: "Cloud Analysis course discussion note on ASICs and machine learning"
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
authorEmoji: 🐹
tags:
- machine learning
- asics
categories:
- Coding
- Course notes
---

### How could ASICs play an important role in Machine Learning going forward?

Machine learning tasks, including the training and the inference, usually cost a lot of computational resources and time. So there is a big need for a hardware acceleration. Hardware acceleration is when dedicated hardware, usually in the form of a GPU today, is used to speed up the computing processes present in an AI workflow. Accelerators have many optimisations that make them suitable for training and executing an AI model, and here are some of them:

Parallelism: ML is inherently parallel workload, so it would be one of the biggest requirement for hardware acceleration

Low-Precision Arithmetic: ML jobs usually works with floating-point numbers, and reducing the precision or ‘detail’ of floating-point operations provides an easy way to increase the effectiveness of the hardware.

Advanced Low-Level Architecture: ML-specific chips usually implemented new ways of organizing physical architecture on the chips to achieve better optimization for deep learning applications. An example would be google’s Tensor Processing Unit(TPU). It brings memory and CPU unit closer together to better perform TensorFlow tasks.

Allowances For In-Memory Processing: The accelerator will also need to make allowances for the smooth execution of in-memory analytics, which speeds up the training by increasing access to the dataset. This includes a high-speed interconnect between the processing unit and the memory (currently HBM2), along with a larger pool of memory to fit big datasets.

Application Specific Integrated Circuits, or ASICs, are chips that are designed and manufactured for a specific purpose, task, or application. As opposed to FPGA(Field Programmable Gate Arrays) which are rewritable and reprogrammable, ASICs are permanent and cannot be modified. ASICs do tend to have the best efficiency, performance, as well as power as compared to FPGAs. Although FPGAs are flexible, they can be quite difficult to make and expensive as well. Also they are not as good in terms of performance comparing to GPUs and ASICs. Of course, CPUs can also be used to train and execute ML models, they tend to provide less performance power than optimized hardware chips. GPUs are flexible and fast, their underlying matrix operations and scientific algorithms makes them ideal for graphics. With ASICs, you get the best of all worlds as it is basically a customizable chip that can be designed to accomplish a very specific task at high power, efficiency, and performance.

## References
https://anysilicon.com/introduction-to-artificial-intelligence-in-asics/

https://analyticsindiamag.com/why-asics-are-becoming-so-widely-popular-for-ai/
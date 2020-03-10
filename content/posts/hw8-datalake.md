---
title: "Cloud Analysis Course Notes - Cloud Storage and Data Lakes"
date: 2020-03-10T01:05:21Z
draft: false
description: "course notes on different storage and data lakes."
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
math: true
authorEmoji: 🐹
tags:
- data lakes
- cloud storage
categories:
- Coding
- Course notes
---

### What are the key differences between block and object storage?

I found this comparison and found it very helpful:

|    |	Block Storage  |	Object Storage |
| ----|------------------|----------------- |
|Performance	| Performs best for big content and high stream throughput |	Strong performance with database and transactional data |
|Geography |	Data can be stored across multiple regions |	The greater the distance between storage and application, the higher the latency |
|Scalability | Can scale infinitely to petabytes and beyond |	Addressing requirements limit scalability |
|Analytics |	Customizable metadata allows data to be easily organized and retrieved |	No metadata |

Block storage means saving data in blocks, or raw storage volumes. Blocks can be seen as fixe-sized chunks. Programs only uses address to identify the blocks, and organize them to form the complete file. There’s no metadata associated with blocks. Therefore performance is faster when application and storage are local. However when they are farther apart, latency can be greater. 

Another way of understanding block storage devices is that each block can be treated like a disk drive controlled by an external server operating system. Block storage is the most commonly used storage type for most applications and it can be either locally or network-attached(example: Amazon’s Elastic Block Storage service). Its typical usages are databases, any application which requires service side processing(like JAVA, PHP, and .Net), and mission-critical applications which all require low-latency operations.

Object Storage means bundling data with customizable metadata tags and a unique identifier to form objects, which are stored in a flat address space(memory is treated as a single contiguous block with a single integer offset, starting from 0 to the maximum address). 

Data kept on object storage devices, unlike data stored in block storage devices which can only be accessible when a block is mounted onto an OS, can be accessed directly through APIs. This guarantees data will not be lost and highly scalable. Its typical use cases are unstructured data like music, image, and video files, backup files, large data sets, and archive files. One example of object storage in the cloud is Amazon S3.

### What are the key problems a Data Lake solve?
A data lake is a collection of all the data sources that a company collected about their customer, their transactions, operations and more. Back in the days companies may have separate data sources for different data, and people need to hop here and there to find the things that they are looking for. Data lakes solves this problem by bundle all the data together so that you can search and analyze things all in one place.

Data lakes use a structure without schema to organize data sources.  Unique identifiers and meta tags are usually added to data so that you can easily find what you need, and different formats of data can be left as they are.

It is worth mentioning the differences between data lake and data warehouse to better understand the problem. Data in a data warehouse are highly organized and aren’t in their original form, but transformed in some pre-defined structure in the warehouse. This characteristic helps a data warehouse to solve a specific type of problem, but it may not be suitable to solve others. Data lakes however can be applied to various problems and its lack of tight structure make it versatile and flexible.

#### What are data tags and how are they achieved?
 I believe you can setup a automated process of adding tags of basic info(data source, type, time, size, schema, etc), profiling info, across datasets info(primary key, foreign key, potential significant overlap), and business tags everytime new data is ingested into the data lake. As of how to achive that there's many data discovery tools and code packages that can extract data tags.

## References
https://cloudian.com/blog/object-storage-vs-block-storage/

https://www.enterprisestorageforum.com/storage-technology/object-storage-vs-block-storage.html

https://cloudacademy.com/blog/object-storage-block-storage/

https://www.datameer.com/blog/whats-data-lakes-five-questions-answered/

https://www.persistent.com/blogs/tags-first-read-fast-step-to-discover-explore-and-enrich-your-data-lake/
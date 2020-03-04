---
title: "Cloud Analysis course notes - Cloud Databases"
date: 2020-03-04T19:10:57Z
draft: false
description: "Cloud Analysis course discussion note on ASICs and machine learning"
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
authorEmoji: 🐹
tags:
- cloud databases
- cloud computing
- aws
categories:
- Coding
- Course notes
---


### What are the problems with a “one size fits all” approach to relational databases?
In the past, the reason why so many businesses model their data to try and fit the use cases of a relational database is that there is no other choice, so in reality many kinds of data are actually not suitable for relational model. Of course this is not to say relational databases cannot provide scalable, available and high performance service, it’s just that we now have many other database models to better suit different use cases. Here is a list of purposes for various types of databases:

**Relational**: Developers rely on the functionality of the relational database to enforce the schema and preserve the referential integrity of the data within the database. Typical use cases for a relational database include web and mobile applications, enterprise applications, and online gaming.

**Key-value**: Key-value databases are highly partitionable and allow horizontal scaling(adding more machines to the resource pool) at levels that other types of databases cannot achieve. Use cases such as gaming, ad tech, and IoT lend themselves particularly well to the key-value data model where the access patterns require low-latency Gets/Puts for known key values. 

**Document**: Data is usually saved as JSON documents. Developers can persist data using the same document model format that they use in their application code.

**Graph**: A graph database's purpose is to make it easy to build and run applications that work with highly connected datasets. It’s best used to reflect the relationships between the nodes in graphs. Typical use cases for a graph database include social networking, recommendation engines, fraud detection, and knowledge graphs.

**In-memory**: Financial services, Ecommerce, web, and mobile application have use cases such as leaderboards, session stores, and real-time analytics that require microsecond response times and can have large spikes in traffic coming at any time.

### How could a service like Google BigQuery change the way you deal with Data?
BigQuery is a query service that allows you to run SQL-like queries against multiple terabytes of data in a matter of seconds. Is serverless, geared toward real-time analytics or big data analytics, automated backup and restore in the case something bad happens, gives developers access via REST API and SDKs including access via SQL, offers high availability so there is minimal to no downtime, has flexible pricing model where you only page for what you use and allows the use of standard SQL dialect so developers can transition from relational database to BigQuery without much learning difficulties.

### What problem does a "serverless" database like Athena solve?
Athena offers teams a serverless front-end SQL query engine for an ETL or ELT process to an AWS S3 data lake. It is serverless, this means no infrastructure to manage. This also means you on ly pay for the queries you run, which will minimize costs. It is not a database service so you don’t have to go through the hassle of setting things up and managing the infrastructures.

## References
https://www.allthingsdistributed.com/2018/06/purpose-built-databases-in-aws.html

https://blog.openbridge.com/what-is-google-bigquery-5598778e5aeb



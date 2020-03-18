---
title: "Vue Eslint Config"
date: 2020-03-18T20:25:25Z
draft: false
description: "learnings about eslint plugin configurations"
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
math: true
authorEmoji: 🐹
tags:
- vue
categories:
- Coding
---


Here are some notes about eslint and its rule configuration I learned along the way:
This is what I have in the `package.json` configuration file:
```json
"eslintConfig": {
    "root": true,
    "env": {
      "node": true
    },
    "extends": [
      "plugin:vue/base",
      "eslint:recommended"
    ],
    "parserOptions": {
      "parser": "babel-eslint"
    },
    "rules": {
      "no-console": 0, 
      "no-unused-vars": 0,
      "no-debugger":0
    }
  },
```

Since I'm still learning and half way through the code there may be some unused variables or components, I turned `no-unused-var` off. For debugging purposes I also turned `no-debugger` and `no-console` off so that I can set breakpoints and log messages during development.

Also the default configuration generated using vue-cli had `"plugin:vue/essential"` in the `extends` field where it enforces error prevention and enables the `vue/no-unused-component` rule. I changed it to `"plugin:vue/base"` to get rid of the error everytime I registered but haven't got around to use the component. 

I Know these are bad practices and you can never be too strict on increasing the readability of the code. However this is just to note down what I did during development for future references.

reference:

https://eslint.vuejs.org/rules/
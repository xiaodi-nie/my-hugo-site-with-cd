---
title: "Vue Basics"
date: 2020-05-30T01:45:53Z
description: "Basic usage and some notes on Vue.js"
draft: false
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
authorEmoji: 🐹
tags:
- vue
categories:
- Coding
---

Here are some basic structure and usage of Vue. The code snippets are taken from [TyrangYang's bill recorder](https://github.com/TyrangYang/awesome-bill-recorder) project that I helped with.

### Basic structure
```html
<template>
    <div></div>
</template>
<script>
    export default {
        name: '',
        props: [...],//data passing
        data() {
            return {};
        },
        computed:{
            ...
        }
        methods: {
            ...
        }
    };
</script>
<style lang="css"></style>

```

### Directives
#### v-for, v-bind, v-on
```html
<option
    v-for="(user, idx) in Users"
    :key="idx"
    :value="user.id"
    @mousedown.prevent="multiSelectEvent"
    >{{ user.name }}</option
>

```
Here ```v-bind:key=``` can be abbreviated to ```:key=```. ```v-on:mousedown``` can be abbreviated to ```@mousedown```

#### v-if
```html
<div v-if="errors.length">
    <b>Please correct the following error(s):</b>
    <ul>
        <li v-for="(error, idx) in errors" :key="idx">{{ error }}</li>
    </ul>
</div>

```
It is not recommended to use v-if and v-for in the same tag. The good thing about ```v-if``` is that if the statement returns false, everything within the tag containing ```v-if``` will NOT be executed and rendered. But if ```v-for``` and ```v-if``` are contained in the same tag the loop will be executed and rendered either way.

#### v-show
```html
<span v-show="unevenlySplit && amount === ''" style="color: red"
    >(amount should not empty)</span
>
```

#### v-model
```html
<select class="sortSummary" v-model="sortModel">
    <option value="0">Not sort</option>
    <option value="1">Sort by Payer</option>
    <option value="2">Sort by receiver</option>
</select>
```
```v-module = "something"``` is equivalent to ```:value="something @input="something = $event.target.value```.

### Vue.set
You can't use the ```[]``` operator to modify value of an object in Vue. It actually will modify the value, but this change to the component state will not actually make any of your application re-render.In order to keep that reactivity, we have to use ```this.$set(<object name>, <key>, <val>)```.


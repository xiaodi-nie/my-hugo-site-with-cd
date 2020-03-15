---
title: "Vue Lifecycle"
date: 2020-03-14T21:19:19Z
draft: false
description: "Notes on vue lifecycle, hooks, and a small example to demo what happens at which stage"
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

I recently started learning vue and here is a little note on what would happen in each stage of the vue lifecycle.

### Lifecycle Diagram
This is a diagram explaining the details from vue.js official docs:

![vue lifecycle](/images/lifecycle.png)

### Project setup
Here we have a basic helloWorld prject generated using vue-cli. In our `App` component there are two variables, `name` and `show`.

In `App.vue` we have a template:
```vue
<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/logo.png">
    <p>{{name}}</p>
    <button @click="update">update data</button>
    <HelloWorld msg="Welcome to Your Vue.js App" v-if="show"/>
  </div>
</template>
```
In `main.js`, `$mount(el)` is called:
```vue
new Vue({
  render: h => h(App),
}).$mount('#app')

```

### Lifecycle hooks
There are several hooks that will be called before and after each stage. You can put some code inside if you want to do things at some stage. These hooks are `beforeCreate()`,`created()`,`beforeMount()`,`mounted()`, `beforeUpdate()`, `updated()`, `beforeDestroy()`, `destroyed()` respectively.

In our source code, `data` and `el` are output to the console in each hook method.

1. `beforeCreate()`, `created()`
   
    `data` and `el` are both undefined when `beforeCreate()` is called. 

    `data` is initialized when `created()` is called, At this stage, the instance has finished processing the options which means the following have been set up: data observation, computed properties, methods, watch/event callbacks. However, the mounting phase has not been started, and the $el property will not be available yet.

2. `beforeMount()`, `mounted()`
    
    Only after `mounted()` is called will `el` be created and initialized. And now, value of `el` is the whole `div` with `id="app"`.
    
3. `beforeUpdate()`, `updated()`

    `beforeUpdate()` is called when data changes, before the DOM is patched. This is a good place to access the existing DOM before an update, e.g. to remove manually added event listeners.

    `updated()` is called after a data change causes the virtual DOM to be re-rendered and patched.

4. `beforeDestroy()`, `destroyed()`
    
    These hooks will only be called when a vue instance is destroyed and no longer exists in the DOM. Here we use a `v-if` to destroy the `helloWorld` component instance to invoke these hooks in the `helloWorld.vue` component source code.
```vue
<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  beforeDestroy(){
    console.log('before destroy')
  },
  destroyed(){
    console.log('destroyed')
  },
}
</script>
```
In our template there's a button and a method called `update` will be invoked on click. In this method, boolean variable `show` will be updated from its initial value `true` to `false`, which will then make `HelloWorld` invisible.

```vue
    <button @click="update">update data</button>
    <HelloWorld msg="Welcome to Your Vue.js App" v-if="show"/>  
```
```vue
methods:{
    update(){
      this.name = 'updated name';
      this.show = false;
    }
  },
```

and after clicking the button, `beforeDestroy()` and `destroyed()` on the `HelloWorld` component will be called.


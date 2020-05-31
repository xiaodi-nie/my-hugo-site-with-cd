---
title: "Vuex Overview"
date: 2020-05-30T23:15:41Z
draft: false
description: "Introduction and basics on Vuex"
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

### What is Vuex
![vuex](/images/veux.png)

Vuex is a centralized state management tool. It extract the shared state out of the components, and manage it in a global singleton. With this, our component tree becomes a big "view", and any component can access the state or trigger actions, no matter where they are in the tree.

### Key concepts
#### State
    
Vuex uses a single state tree - that is, this single object contains all your application level state and serves as the "single source of truth". This also means usually you will have only one store for each application.

#### Getters

Vuex allows us to define "getters" in the store. You can think of them as computed properties for stores. Like computed properties, a getter's result is cached based on its dependencies, and will only re-evaluate when some of its dependencies have changed.

#### Mutations

The only way to actually change state in a Vuex store is by committing a mutation. Vuex mutations are very similar to events: each mutation has a string type and a handler. The handler function is where we perform actual state modifications, and it will receive the state as the first argument

You cannot directly call a mutation handler. Think of it more like event registration: "When a mutation with type increment is triggered, call this handler." To invoke a mutation handler, you need to call store.commit with its type

#### Actions

Actions are similar to mutations, the differences being that:

- Instead of mutating the state, actions commit mutations.
- Actions can contain arbitrary asynchronous operations.

#### Modules

Vuex allows us to divide our store into modules. Each module can contain its own state, mutations, actions, getters, and even nested modules

### Project structure example
```
│   App.vue
│   main.js
│
├───assets
│       logo.png
│
├───components
│       Bill.vue
│       HelloWorld.vue
│       Summary.vue
│       User.vue
│
└───store
    │   index.js
    │
    └───modules
            bills.js
            users.js
```

### Usage
In ```store/index.js```
```javascript
// import vue and vuex
import Vuex from 'vuex';
import Vue from 'vue';
// import module
import users from './modules/users';
import bills from './modules/bills';

// adding vuex
Vue.use(Vuex);

// create store
const store = new Vuex.Store({
    modules: {
        users,
        bills,
    },
});

// export store
export default store;

```

In ```main.js```
```javascript
// Adding...

// import store
import store from './store';

// add store to vue object

new Vue({
    store, // add this line
    render: (h) => h(App),
}).$mount('#app');

```

In ```store/modules/users.js```
```javascript
const state = {
    Users: [
        { id: 'userId1', name: 'testName1' },
        { id: 'userId2', name: 'testName2' },
    ],
};

const getters = { Users: (state) => state.Users };

const actions = {
    async addUser(context, usr) {
        let usr = await axios.post('....', usr);
        context.commit('addUser', usr);
    },
    // or
    async addUser({ commit }, usr) {
        let usr = await axios.post('....', usr);
        commit('addUser', usr);
    },
};

const mutations = {
    addUser(state, usr) {
        state.Users.push(usr);
    },
};

export default {
    state,
    getters,
    actions,
    mutations,
};

```

mapActions, mapGetters, mapMutations

used in component code:
```javascript
import { mapActions, mapGetters, mapMutations } from 'vuex';

export default {
    // ...
    computed: {
        ...mapGetters([
            'doneTodosCount', // `this.doneTodosCount` -> `this.$store.getters.doneTodosCount`
            'anotherGetter', // `this.anotherGetter` -> `this.$store.getters.anotherGetter`
        ]),
    },
    methods: {
        ...mapMutations([
            'increment', //  `this.increment()` -> `this.$store.commit('increment')`

            'incrementBy', //  `this.incrementBy(amount)` -> `this.$store.commit('incrementBy', amount)`
        ]),
        ...mapMutations({
            add: 'increment', //  `this.add()` -> `this.$store.commit('increment')`
        }),
        ...mapActions([
            'increment', //  `this.increment()` -> `this.$store.dispatch('increment')`

            'incrementBy', //  `this.incrementBy(amount)` -> `this.$store.dispatch('incrementBy', amount)`
        ]),
        ...mapActions({
            add: 'increment', //  `this.add()` -> `this.$store.dispatch('increment')`
        }),
    },
};


```

## References
[Vuex documentation](https://vuex.vuejs.org/)
[Bill recorder project](https://github.com/TyrangYang/awesome-bill-recorder)
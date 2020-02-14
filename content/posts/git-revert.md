---
title: "Git Revert"
date: 2020-02-12T03:07:10Z
description: Git revert and its comparison to reset
draft: false
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
authorEmoji: 🐹
tags:
- git
categories:
- Coding
---

The git revert command can be considered an 'undo' type command, however, it is not a traditional undo operation. Instead of removing the commit from the project history, it figures out how to invert the changes introduced by the commit and appends a new commit with the resulting inverse content. This prevents Git from losing history, which is important for the integrity of your revision history and for reliable collaboration.

### Syntax
```
git revert <COMMIT_ID>
```
Here COMMIT_ID can be any form that git recognizes, from regular 40-digit, short SHA-1, to something like 'HEAD'.

This means any change done by <COMMIT_ID> will be reverted and a new commit is created. You will be prompted to enter a regular commit message and after that you can do git push normally.

```
git revert <COMMIT_ID>..HEAD

```
Reverts all the changes done by the commits in between, or similarly you can also do
```
git revert <COMMIT_ID1>..<COMMIT_ID2>
```

### Compare to other 'undo' methods

#### git reset

This is like a complete rollback and it would move the working tree back to the last commited state. No new commit will be created and commits after the designated target may be lost. And it will change the commit history.
You can have several options as to what to do with your **index**(set of files that's going to be the next commit) and the working directory:

```git reset --soft``` will only change the current HEAD to point to another commit, but the index and working directory remains unchanged.

```git reset --mixed``` will change the HEAD pointer and the index, but the working directory will stay the same.

```git reset --hard``` will change everything. This means every change after the other commit will be gone forever.
(However if you accidentally erased something with the --hard option there's always ```git reflog``` to help you get almost everything back)

#### git checkout

This is used to change the HEAD pointer to another commit or switch between branches. It will also rollback file changes after that commit and can change the files in the working directory. The commit history will not be changed.

Typical use cases:

- undo local changes to a file:  ```git checkout file_name```
- undo local commits:
```
git checkout target_branch
git reset HEAD~2 #rollback 2 commits
```

### Git cheat sheet

![git cheat sheet1](/images/git_cheat_sheet1.jpg)

![git cheat sheet2](/images/git_cheat_sheet2.jpg)

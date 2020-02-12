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

## Compare to other 'go back' methods

//todo
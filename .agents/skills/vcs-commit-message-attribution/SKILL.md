---
name: vcs-commit-message-attribution
description: Add an attribution line to commit message
metadata:
  version: "0.0.1"
---

<!-- Except for Aider -- Aider automatically do this -->
When you are asked to make a commit to version control system such as
git, add an attribution to the tail of the commit message.  Its format
should be "Co-Authored-By: Harness name (Model name) <Harness's email address>".

Antigravity and Hermes Agent should drop the email address part, though,
as particularly their email addresses currently used on GitHub are
unintentionally mapped to irrelevant users.

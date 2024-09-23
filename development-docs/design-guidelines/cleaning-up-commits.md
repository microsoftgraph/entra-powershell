# Cleaning up commits

## Best practices for keeping commits clean

During development, to make sure that your commit history stays clean while the branch you're based off of is changing, follow some of these rules:

1. **Rebase instead of merging**
    - When you need to update your branch with the changes made to the base branch, [rebasing](#rebasing) will change the commit that your branch is based off of, allowing you to add the changes from the base branch and not gain an extra commit that you would with merging.
2. **Large number of changes**
    - If you create a pull request that contains a large number of changes (*for example,* re-recording tests) that won't be able to be displayed on GitHub, separate your changes into multiple pull requests that reference each other.

## Number of commits

It can be difficult to follow the changes in a pull request when the number of commits that come with it become too large:

- If a bug fix is being addressed, a single commit should be submitted
- If a new feature is being introduced, then the pull request can have multiple logical commits with each commit clearly describing what it does

## Rebasing

Sometimes a pull request is based on an earlier commit in the branch you're trying to merge into. This can result in a large number of commits and file changes cluttering the pull request. In this case, it would be better to **rebase** (move branches around by changing the commit that they're based on).

For example, if you're working from the branch **feature** and are trying to rebase with **dev**, first pull the latest changes from **dev**:

```git
git pull upstream dev
```

Next, you want to "uncommit" all of the changes in **feature** that differ from **dev**:

```git
git reset --soft upstream/dev
```

Finally, make a few commits with the changes made and push them to your fork:

```git
< commit changes >
git push origin feature -f
```

**Note**: the `-f` must be included when pushing to your fork for the rebase to be successful

For more information on rebasing, click [here][git-rebase].

## Squashing

When your pull request has a group of commits that can be condensed into one, logical commit, use **squashing**. This cleans up the number of commits your pull request has while also grouping together common commits.

For example, if you wanted to squash the last three commits into one, you can run the following command:

```git
git rebase -i HEAD~3
```

This brings up an editor showing your last three commits. Pick a commit to keep (as the message), and squash the other two into it.

For more information on squashing, click [here][squash-commit].

## Cherry-picking

If you want to merge specific commits from another branch into the current one you're working from, use **cherry-picking**.

For example, if you're working on the **main** branch and want to pull commit X (the commit-hash) from the **feature** branch, you can run the following commands:

```git
git checkout main
git cherry-pick X -n
```

The `-n`, or `--no-commit`, is recommended for cherry-picking because it doesn't automatically create a commit for the cherry-picked change. This allows you to review the changes first and ensure that you want to add everything from the cherry-picked commit.

Now, if you want to cherry-pick a range of commits, say X through Y, from the **feature** branch, you can run the following commands:

```git
git checkout -b temp-branch X
git rebase --onto main Y^
```

For more information on cherry-picking, click [here][cherry-pick].

[cherry-pick]: https://git-scm.com/docs/git-cherry-pick
[git-rebase]: https://git-scm.com/docs/git-rebase
[squash-commit]: https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History#Squashing-Commits

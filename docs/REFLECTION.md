# Reflection

**Name:** Nsabimana Simon Brice | **Student ID:** 27451

## What I learned

In Part A I learned how `GOTO` works in PL/SQL and why it is rarely used. It makes code hard to follow because the program jumps around. The `PLS-00375` error showed me that a `GOTO` cannot jump into an `IF` block, only to a label in the same block or an enclosing one. Rewriting A1 without `GOTO` in A4 showed me that `IF / ELSIF / ELSE` is clearer.

In Parts B and C I learned how stored functions return one value that can be used inside a `SELECT`. Test data with edge cases, such as Jean's `NULL` salary, Paul's missing department and employee 999, showed me that every function needs a clear rule for `NULL` or missing input.

## Biggest challenge: Git credentials and identity

The hardest problem in this assignment was not the SQL. It was the Git identity and credentials on the computer I was using. The PC still had the previous user's name and email saved in its Git settings, so my first commits were credited to that person instead of me. I only noticed when I read the commit history with `git log` and saw a name that was not mine.

This was serious because commits are the evidence of who did the work. Wrong authorship could make my work look like someone else's, or make the marker doubt that I wrote it.

I fixed it step by step:

1. I ran `git config --list` to find the old name and email. There was also a local setting inside the repository that overrode the global one, so I had to remove both.
2. I set my own name (Brice-Simon) and email.
3. I rewrote the author on my earlier commits with `git rebase --root --exec "git commit --amend --no-edit --reset-author"`, then pushed the corrected history with `git push --force-with-lease`.
4. I checked with `git log --format="%an <%ae> %s"` that every commit shows my name.

What I learned from this:

* On a shared or lab computer, I must check `git config --list` and any saved GitHub credentials before the first commit, not after.
* Saved credentials and Git settings belong to the computer's previous user, not to me, so I must set my own and not trust the defaults.
* Rewriting history and force pushing can destroy work if done carelessly. I used `--force-with-lease` and only did it on my own new repository.
* I should read the author line of my first commit right after making it.

## Other challenges

I also hit the clone error 400 from the `< >` brackets, ran git commands outside the repo folder, and saved screenshots with a `.png.png` double extension. Each one taught me to read error messages carefully and to check file names and folders.

## What I will practice next

Before the quiz I want to practise writing `GOTO` programs and functions from memory, including where labels can go, what each function returns for `NULL`, and which exception it catches.

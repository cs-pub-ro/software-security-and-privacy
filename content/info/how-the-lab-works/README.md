# How the Lab Works

This is the practical half of the Software Security and Privacy class: finding and exploiting vulnerabilities on Linux, then understanding the defences that stop them and the ways around those defences.

Something very important: [ask the teaching assistant](#ask-the-teaching-assistant).
Whenever you are stuck, unsure what a task wants, or lost in an explanation, ask — that is what the teaching assistant is there for.

## What you need

* A Linux environment on an x86-64 machine: your own installation, the class virtual machine, a container, or one of the faculty's lab machines.
  Most exploitation challenges are 32-bit x86 binaries, so an ARM machine will not do for those sessions without an emulated x86 virtual machine.
* The tools each session uses, listed in the *Prerequisites and required tools* section of that session's `README.md`.
* An account on the [CTF platform](../resources/README.md), where the challenges are deployed and flags are submitted.
* A terminal you are comfortable in, and the habit of reading `man` pages.

## Check setup

Check that your system has all it needs for the lab, by downloading and running the [`check-prerequisites.sh` script](https://github.com/cs-pub-ro/software-security-and-privacy/blob/master/scripts/check-prerequisites.sh):

```console
wget https://raw.githubusercontent.com/cs-pub-ro/software-security-and-privacy/refs/heads/master/scripts/check-prerequisites.sh
chmod a+x check-prerequisites.sh
./check-prerequisites.sh
```

The script installs nothing.
It reports what is missing and prints the command that installs it on your distribution.

If something is missing, be sure to install and configure it.

## How a session is structured

Every session is one directory, and the tasks inside it come in three kinds.
The kind is the prefix of the task directory name:

* `demo-*` — the warm-up, worked through together with the teaching assistant at the start of the session.
  The demo sets up the technique that the tasks after it build on.
* `NN-*` — the core tasks, solved individually or in teams, in their numeric order.
  They usually build on one another, and this is the part of the session that matters most.
* `bonus-*` — optional, for when you are through the core tasks, or to take home.

A session runs through those three kinds in that order.
You do a demo together with the teaching assistant, then move on to the core tasks, and finally, for those who get that far, to the bonus tasks.

The session's own `README.md` is the map: what you should be able to do by the end, what you need installed, and the order the tasks are taken in.
Read it first.

Inside a task directory:

* `README.md` is the task itself: the goal, the background you need, what to do, how to build and run it, and how to check your work.
* `FURTHER.md`, where there is one, holds extensions and questions to dig into once the task works.
  It is optional, and it is worth your time when the core tasks are done.
* The challenge files: usually the source of a vulnerable program, the binary built from it, and sometimes a skeleton exploit with `TODO` markers.

## Capture the flag

Most tasks are capture-the-flag (CTF) challenges.
A vulnerable program runs on a server, and a secret string, the flag, sits next to it where the program alone would never show it.
Your job is to make the program misbehave in a way that hands you the flag.

1. Work locally first.
   The task directory has the program and its source: run it, read it, find the bug, and build an exploit that works on your machine.
1. Then aim it at the deployed challenge.
   The address of each deployed challenge is listed on the CTF platform, in the category of the session.
1. Submit the flag you capture on the platform.

A flag looks like `SSP{...}`.
A local run reads a flag file you create yourself, so a local "flag" proves the exploit works, not that you have the real one.

Attack only the challenges deployed for the class, at the addresses the platform lists.
Everything you learn here works on real systems too, and using it on a system you have not been given permission to test is illegal.

## Working through a task

1. Read the whole `README.md` before doing anything, including *Check Your Work*.
   Knowing what "done" looks like changes how you start.
1. Read the source before you run the binary, and run the binary before you write the exploit.
1. Change one thing at a time, and run it.
1. Measure instead of guessing.
   An offset read off a debugger is evidence; an offset that worked once by trying numbers is luck.
1. Keep your exploit in a script, not in your shell history.
   You will run it many times, locally and remotely.

## Good practices

* **Look at the binary before attacking it.**
  `file`, `checksec`, `objdump -d` and `readelf` tell you the architecture and which defences are on, which decides what kind of exploit can work.
* **Use a debugger to see what really happens.**
  `gdb` shows the stack, the registers and the memory at the moment the program goes wrong; a crash you have looked at is a crash you can explain.
* **Write payloads as bytes, in a script.**
  `pwntools` packs addresses in the right byte order and talks to local processes and remote services the same way.
* **Read the manual page of functions you call or attack.**
  `man 3 gets` explains, in its *BUGS* section, why half of these challenges exist.
* **Write it yourself.**
  Using an AI assistant to produce the exploit during the lab defeats the purpose of the lab: the skills here are built by trying, failing, and understanding why.
  Talk to your colleagues, compare approaches, explain your bug out loud — that is the kind of help that leaves something behind.

## Ask the teaching assistant

The teaching assistant is in the room for exactly this: to be asked.
Ask when you are stuck, ask when the task is not clear, ask when the output makes no sense, ask when something said during the demo went past you.
Ask for directions, too, not only about errors: which approach to take, whether what you have written is a sane way to do it, why the program behaves the way it does, what to look at once a task works.
No question here is too small, too basic or too late.

Ask early rather than after twenty minutes of staring at the same screen.
A misunderstanding caught in its first minutes costs you one question; the same misunderstanding carried to the end of the session costs you the session.
Asking is not an admission that you are behind — it is the whole point of having a lab instead of a book, and everyone in the room is expected to do it.

If you captured a flag and you are not sure *why* the exploit works, that is also worth a question.
Take your results to the teaching assistant and explain them: the *Check Your Work* sections are written to give you something to discuss rather than an output to match.

## Getting unstuck

None of this replaces asking; it is what makes the answer land on something concrete.
Before you raise your hand, if you have a minute for it, try:

1. Re-read the task and the source, and say out loud what each line is supposed to do.
   The line where the sentence sounds wrong is usually the bug.
1. Check what defences the binary has, and whether your approach can work against them.
1. Run the exploit locally, under the debugger, and stop right before the point where it should take over.
1. Compare what is in memory with what you meant to put there.
1. Ask a colleague sitting next to you.

Then ask the teaching assistant, and bring what you have: the command you ran, the output you got, the output you expected, and what you have already tried.
This is not just politeness, it is half of debugging — a surprising number of bugs are solved out loud while describing them.
And if the minute is not there, or the bug has already eaten it, ask anyway.

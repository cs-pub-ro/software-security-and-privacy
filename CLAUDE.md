# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

Teaching material for the Software Security and Privacy class (formerly Security of Information Systems, SIS), 14 lecture and lab sessions, published at <https://cs-pub-ro.github.io/software-security-and-privacy/>.
The practical part is mostly capture-the-flag (CTF) challenges on Linux: exploiting binaries and web applications, defences and how to bypass them, confinement, isolation, code analysis, supply chain, fuzzing and verification.
There is no application to build — the deliverables are task directories (challenge files or sources + `Makefile` + `README.md`) and the website and lab archives generated from them.

The layout, the generator and the style rules are copied from the `operating-systems` class repository, and are kept the same on purpose so that both classes can share tooling.
The previous material lives in two read-only reference repositories next to this one: `sis-internal` (Beamer slides, the Sphinx lab pages, the newest challenge sources) and `sis-private` (2022 challenge deployments and write-ups).
Port from them; do not modify them.

AI use is discouraged *for students during the lab*; the point is that they write and build the programs by hand.
Content written here has to leave them something to do.

## Content layout

Everything published lives under `content/`, one directory per part of the class:

* `content/lectures/` — the lectures.
* `content/labs/` — the labs.
* `content/assignments/` — the assignments.
* `content/extra/` — additional material.

Inside a section, each session lives in two sibling directories:

* `NN-<session-name>-live/` — what is used while the session runs. For a lab: skeletons with `TODO` markers, task descriptions, hints; never a complete solution. For a lecture: a one-pager with the plan of the lecture and the points to capture.
* `NN-<session-name>-full/` — reference solutions, full explanations, reference command output, the exploits and the Docker files that build and deploy the challenges, and the `prompt.txt` notes the exercises were generated from. Used by students after the session and by assistants before it. A lecture's `-full/` half holds subdirectories exactly the way a lab's does, and the site renders them the same way.

The website publishes the two halves as two separate views, and the view is the first part of the URL, so `content/labs/03-exploit-app-live/` is served at `/live/labs/03-exploit-app/` and its `-full/` sibling at `/full/labs/03-exploit-app/`.
A section with no halves stays at the top level: `content/assignments/` is `/assignments/`.

Inside a **lab** session, the directory-name prefix is the task type, and it is load-bearing (the site and the archives key off it, and so do the README conventions below):

* `demo-<name>/` — solved together with the teaching assistant at the start of the session.
* `NN-<name>/` — core exercise, solved individually or in teams, in numeric order.
* `bonus-<name>/` — optional; for students who finish early, or as homework.

A **lecture** session is laid out by kind rather than by task type, and both halves use the same three directories:

* `media/` — the figures the READMEs and the slides show, one subdirectory per part of the lecture (`02-stack/`, `03-shellcode/`, …).
  Excalidraw drawings are committed as the PDF the tool exports plus an SVG converted from it by `scripts/gen_media.sh`; draw.io drawings keep their `.drawio` source beside the SVG.
  The SVG is what a README points at, because a browser will not show a PDF through an `![...]()`.
* `demos/` — the programs demonstrated during the lecture, numbered to match the parts.
  The sources live in the `-full/` half and there is exactly one copy of each; the `-live/` half holds only the command sheet for each demo — what to type, and the question to put to the room.
* `slides/` — one Quarto deck (`*.qmd`), rendered to reveal.js by `scripts/render_slides.sh` and published with the website.
  The `-live/` deck is minimal (at most 15 slides: diagrams, demo results, questions); the `-full/` deck follows the session `README.md` with the detail filled in.
  `make` in a `slides/` directory renders the HTML, `make pdf` renders the same deck through beamer.
  Rendered decks are generated and are not committed.

Pacing, which demos to run live and what to cut go in the lecture's `-full/INSTRUCTOR.md`, never in a `-live/` README.

Every task directory is freestanding: no symlinks, no shared Makefile fragments, so it survives being unzipped on its own.
Per-exercise `.gitignore` lists only the binaries that task builds — object files and the like are already covered by the top-level `.gitignore`.

Per task, up to four Markdown files, with a strict division of labour:

| File | `-live/` | `-full/` |
| --- | --- | --- |
| `README.md` | the task | the tutorial |
| `FURTHER.md` | optional extensions, questions, discussion points | same, with answers |
| `INSTRUCTOR.md` | never | notes for whoever runs the session |
| `prompt.txt` | never | the note the exercise was written from (excluded from student archives) |

## README conventions

Session-level `README.md` (both directories): learning objectives, prerequisites and required tools, and a task-order table (order, task, type, objective).

Exercise `README.md` in `-live/`:

```text
# <Exercise|Bonus>: <Title>

**Tools:** GCC, GDB, pwntools

## Goal            (1-3 sentences: what you will be able to do afterwards)
## Background      (only what is needed; link out for more)
## Your Task       (numbered, checkable)
## Build & Run
## Check Your Work
```

Demo `README.md` in `-live/` is deliberately minimal: a short paragraph on the aim, and a note that the work is done together with the teaching assistant on the files in the directory.

Exercise `README.md` in `-full/` is a tutorial: Goal, Background, Build & Run, Results and Explanations, Going Further, References.
Sections may be dropped where they do not apply.

Rules that are easy to violate, all of them deliberate:

* Keep a `-live/` exercise README under ~80 lines. Reading time is time not spent working. Go over only when it earns it.
* **No expected output** in *Check Your Work*. Describe what the output should look like and what to reason about, so students interpret it and take it to the teaching assistant instead of pattern-matching.
* **No *Going Further* section** in a `-live/` README — that content belongs in `FURTHER.md`.
* **Do not link to `FURTHER.md`** from a `-live/` README either; students should not feel obliged to open it.
* **No time budgets** anywhere in student-facing files, and no "After the session" section. Groups and assistants move at different paces. Time estimates and pacing advice go in `INSTRUCTOR.md`.
* Anything addressed to the teaching assistant — pacing, which demo to pick, what students get wrong — goes in `INSTRUCTOR.md`, not in a `README.md`.

## Markdown style

`dev/content-rules.md` is the source of truth and `.markdownlint-cli2.jsonc` enforces most of it. The two that a linter cannot catch and that matter most:

* **One sentence per line.** A four-sentence paragraph is four lines, each starting at column zero (indented to match, inside a list item). This keeps diffs readable.
* Shell commands use ```` ```console ````, not ```` ```bash ````; `bash` is only for actual shell scripts. Every fenced block gets a language; use `text` when nothing fits.

Also: `*` for unordered lists, `1.` for *every* ordered item, blank line around lists and fences, no trailing whitespace.

## CTF tasks

A CTF task follows `operating-systems/content/labs/05-memory-security-*`, which is the same layout in the other class:

* `-live/NN-<chall>/` holds what players receive: `README.md`, `FURTHER.md`, and the challenge files (source, binary, a skeleton `exploit.py` when there is one).
* `-full/NN-<chall>/` holds the write-up (`README.md`), `FURTHER.md`, `INSTRUCTOR.md`, a placeholder `flag`, and four directories, each with a `Dockerfile` and a `README.md`:
  `build/` (compiles the challenge from source), `publish/` (extracts the files players get), `deploy/` (serves the challenge: xinetd for a binary, sshd or a web server for the others), `solve/` (runs the reference exploit against a deployment).

Rules that are specific to this class:

* **Flags are placeholders.** A `flag` file holds `SSP{placeholder}`; `deploy/` takes the real flag as a build argument (`ARG FLAG`) and writes it where the challenge reads it, mode 400, owned by root, readable by the challenge user only through the bug.
  Real flags are set when a deployment is made and rotated every year; they are never committed.
* **No flag in a binary.** A challenge reads its flag at runtime; a shipped binary must be safe to hand out.
* **No server addresses in a README.** A `-live/` README says the challenge is reachable at the address listed on the CTF platform, in the session's category; addresses and ports are in the `deploy/README.md` and the session `INSTRUCTOR.md`.
* `solve/` checks that what it captured starts with `SSP{`, not that it equals a literal, so it works with whatever flag a deployment was given.
* Most exploitation challenges are 32-bit x86 (`-m32`); their `build/` image installs `gcc-multilib`, and the challenge ships the libc and loader it was linked against when the layout depends on them.

## Commands

```console
npx --yes markdownlint-cli2@0.23.2 "**/*.md"    # add --fix <file> to repair one file
git ls-files -z '*.sh' '*.bash' | xargs -0 shellcheck
```

Never pass `--fix` without naming files: the config deliberately has no `globs` key, but a bare glob would rewrite the whole tree.

Building an exercise is `make` inside its directory; most also have `make test`, `make bench`, `make run` or similar — read the `Makefile`, they differ per task.

Site and archives:

```console
pip install -r dev/requirements.txt
./scripts/render_slides.sh        # content/**/slides/*.qmd -> self-contained HTML
./scripts/gen_media.sh            # content/**/media/*.pdf -> SVG, committed
mkdocs serve                      # http://localhost:8000, rebuilds on change
mkdocs build                      # into _site/
python3 scripts/gen_zip.py        # student archives into archives/ (git-ignored)
```

`render_slides.sh` needs Quarto and has to run before the site is built, because `gen_pages.py` publishes whatever decks are on disk when it walks `content/`; the Pages workflow does both in that order.
`gen_media.sh` needs `pdftocairo`, and its output is committed, so building the site needs neither tool.

C style is the Linux kernel's `checkpatch.pl`, fetched by `.github/workflows/lint.yml`; only lines a push or PR changes must be clean, the rest of the tree is reported in the run summary.

## Generation pipeline

`scripts/sessions.py` defines what a section, a session and a task are; `gen_pages.py` (website, via `mkdocs-gen-files` + `mkdocs-literate-nav`) and `gen_zip.py` (student archives, published to the `lab-archives` branch) both ask it, so the two can never disagree.
Nothing is stored: pages and navigation are discovered by walking `content/` at build time, so adding a section, a session or a task means creating the directory and writing its `README.md`, nothing else.

* The website is two views of `content/`, not one tree: `/live/<section>/<session>/…` and `/full/<section>/<session>/…`, with the variant suffix dropped from the URL because the view already says which half it is.
  Both halves are published — `-full/` is what students read after the session — but never listed side by side: `navigation.tabs` makes each view a tab, so a page's sidebar and generated lists hold only its own view.
  The tab bar is the one place both appear, and a deliberate cross-reference in prose (each `-full/` README points at its `-live/` half) still links across.
  `site_tree()` in `sessions.py` does the splitting; `gen_pages.py` keeps a map of every published directory to its URL, which is what link rewriting goes through.
* Lectures and labs are the same thing to the generator. A `-live/` lecture that is only a one-pager is a session with nothing below it; the moment subdirectories are added to a `-full/` lecture they render exactly like a lab's exercises.
* A session brings its assets with it. Everything below it whose suffix is in `ASSET_SUFFIXES` (`sessions.py`) — the SVGs under `media/`, the decks rendered into `slides/` — is copied into the site at the path it has below the session, so a relative link from a README to a figure is left exactly as written rather than rewritten.
  Anything else (a `.c` file, a `Makefile`) has no page and is linked to on GitHub, as before.
  `old/` is in `EXCLUDED_DIRS`: it is the staging area a session keeps while it is being rewritten, and it is published no more than it is linted.
* A section or session `README.md` that is still only a title gets a generated list of what is below it — only of the view being built — and one with a level-two heading anywhere in it is left alone, which is why the lab session pages keep their own task table.
  A section README is rendered once per view it has sessions in.
* `gen_zip.py` packs `content/labs/*-live/` and nothing else (`ARCHIVE_SECTION`, `ARCHIVE_VARIANT` in `sessions.py`), only git-tracked files, and drops `prompt.txt` / `*-prompt.txt`, so a stray `.o` or a solution note never reaches students.
  `is_reference()` is the second line of defence: packing aborts outright if a path below a `*-full/` directory, or a `solutions/` one, ever reaches an archive.
  This is what keeps the exploits and deployment files out of what ships; run `unzip -l` on an archive before handing it to anyone regardless.

See `scripts/README.md` for the details.

## State of the content

The port from `sis-internal` is in progress; `dev/internal-residue.md` lists the files met on the way that belong in the future internal repository rather than here (real flags, server addresses, lecture tests).
Session 03 (`content/labs/03-exploit-app-*`, `content/lectures/03-exploit-app-*`) is the model session: port it first, then use it as the model for every other one.

## Third-party content

Code imported from elsewhere, such as the `http-parser` library the fuzzing session targets, goes under a `utils/` directory inside the task that uses it.
`utils` is in `EXCLUDED_DIRS` (`scripts/sessions.py`), so it is packed with its task but gets no page, and the `VENDORED` path in `.github/workflows/lint.yml` and the ignores in `.markdownlint-cli2.jsonc` keep it out of checkpatch and markdownlint.

Small files students are expected to read and modify get reformatted to our style; large files they only use, and anything tracking an upstream that is periodically re-synced, stay as they are.

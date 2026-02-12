# Slide styleguide (Statistics 2026)

This document defines how future lecture slides should be built in this course.

It is written for both humans and machines and is based on the existing slide decks in the course folders.

---

## 0) Basic info

Here is the basic information of the course. Please reference this, when needed.

1. **Name of course:** `Statistics`
4. **Name of lecturer:** Christian Vedel
5. **Lecturer affiliation:** Department of Economics
6. **Lecturer contact email:** christian-vs@sam.sdu.dk

---

## 1) Design goals (always apply)

1. **Avoid clutter**: one core idea per slide.
2. **Prioritize clarity over density**: short bullets, clear headings, enough whitespace.
3. **Teach progressively**: introduce difficult concepts step by step.
4. **Be consistent**: same structure, classes, and notation across all lectures.
5. **Keep slides practical**: include examples and mandatory practice prompts.

---

## 2) Required technical setup (MUST)

Every lecture deck should follow the same technical scaffold:

- Output format: `xaringan::moon_reader`
- 16:9 ratio
- `insert-logo.html` included via `after_body`
- `self_contained: false`
- `lib_dir: libs`
- xaringan extras enabled:
	- panelset
	- tile view
	- progress bar (`#808080`, top)
- CSS utility classes included:
	- `.pull-left`, `.pull-right`
	- `.pull-left-wide`, `.pull-right-wide`
	- `.pull-left-narrow`, `.pull-right-narrow`
	- `.tiny123`, `.small123`, `.large123`
	- `.red`, `.orange`, `.green`

Use [Statistics/XX_Template/Slides.Rmd](../XX_Template/Slides.Rmd) as the base template.

---

## 3) Deck-level structure

### Title slide (MUST)
The opening slide should include:

- Course name (`# Statistics`)
- Lecture topic title (`## ...`)
- Optional chapter reference (`### (Chapter X)` where relevant)
- Lecturer name + affiliation
- Email as clickable mailto link
- `### Updated `r Sys.Date()``

Title slide class should be:

- `class: center, inverse, middle`

### Agenda / roadmap slide (SHOULD)

- Prefer a "This lecture" slide near the beginning.
- Usually use `.pull-left-wide[]` for agenda bullets.

### Section divider slides (MUST)

Use this class for major transitions:

- `class: inverse, middle, center`

Keep divider content short (typically one section title).

---

## 4) Slide composition rules

1. **Default body layout**: put main content in `.pull-left-wide[]`.
2. **When adding visual support**: pair with `.pull-right-narrow[]` (image, key note, reminder).
3. **Comparison slides**: use `.pull-left[]` + `.pull-right[]` (balanced columns).
4. **Figure-only emphasis**: use `.center[]` around image where useful.
5. **Footnotes / side notes**: use `.small123[]`, optionally inside `.footnote[]`.

---

## 5) Content style and pedagogy

### Text style

- Prefer concise bullets over long paragraphs.
- Bold terms on first introduction.
- Use blockquotes (`> ...`) for formal definitions and key statements.

### Progressive reveal

- Use `--` to reveal points step by step.
- This is the default method for pacing complex derivations or lists.

### Practice slides

- Practice prompts are **mandatory**.
- Include practice slides throughout the lecture.
- As a default rule, add at least one practice slide per major concept/section.
- Existing pattern: red heading label, e.g. `# .red[Practice: ...]`.
- Optional hidden teacher answer chunk:
	- `eval=FALSE, include=FALSE`

### Tone

- Professional, direct, and student-friendly.
- Pragmatic focus: explain why concepts matter and how to use them.

---

## 6) Math, notation, and equations

1. Use LaTeX math consistently (`$...$`, `$$...$$`).
2. Keep notation consistent with course conventions:
	 - Random variables uppercase (`X`, `Y`)
	 - Realizations lowercase (`x`, `y`)
3. Display important formulas on separate lines.
4. Prefer one major equation block per teaching step.

---

## 7) Figures and media

1. Store lecture assets in the lecture's `Figures/` folder.
2. Use relative paths (e.g., `Figures/filename.png`).
3. Prefer markdown image syntax for normal use.
4. Use HTML `<img ...>` only when explicit size control is needed.
5. Ensure each visual has a pedagogical purpose (not decorative only).

---

## 8) Code chunks and reproducibility

1. Use code only when it supports the concept.
2. Keep setup/helper chunks silent (`echo=FALSE` when appropriate).
3. For hidden instructor notes/solutions, use `eval=FALSE, include=FALSE`.
4. Keep chunk names descriptive.
5. Avoid verbose output on slides.

---

## 9) Consistency checklist before publishing

Before finalizing a deck, verify:

1. Title slide fields are updated (title, lecturer, email, date).
2. Section divider slides are in place.
3. Layout classes are used consistently.
4. Notation is consistent throughout.
5. Figures render and paths work.
6. No placeholder text remains.
7. Slides knit successfully to HTML.
8. Practice slides are included for each major section/concept.

---

## 10) Default instruction block for future slide generation (machine-readable)

When generating a new lecture deck, follow these rules in order:

1. Start from [Statistics/XX_Template/Slides.Rmd](../XX_Template/Slides.Rmd).
2. Keep all xaringan/xaringanExtra setup chunks and CSS utility classes.
3. Build title slide with course/topic/lecturer/email/date.
4. Add one agenda slide.
5. Structure lecture into sections separated by inverse divider slides.
6. Put normal slide content in `.pull-left-wide[]` unless comparison layout is needed.
7. Use `--` for incremental reveal when concepts are multi-step.
8. Use blockquotes for definitions and theorem-like statements.
9. Add mandatory practice slides for each major concept/section.
10. Keep visual design minimal and consistent with this styleguide.


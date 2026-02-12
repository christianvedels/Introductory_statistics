# Warm-up worked example: Conditional probability (new, intuitive table)
**Use after slide 41, before slide 42 (Practice: Conditional probability)**

Alright, let's work on a practical problem here.  
Conditional probability means: “change the denominator to the relevant subgroup.”

---

## Problem
A simple hiring pipeline for 200 applicants:

- 80 applicants have prior experience (event $X$)
- 60 applicants get an interview (event $I$)
- 40 applicants have experience AND get an interview

Compute:

1. $P(I\mid X)$  
2. $P(X\mid I)$  
3. Explain in one sentence why they differ

---

## Worked solution
### Step 1 — use the definition
$P(I\mid X)=\dfrac{P(I\cap X)}{P(X)}$

Use counts (cleanest):
- Among the 80 with experience, 40 got interviews  
So:
$P(I\mid X)=40/80=0.50$

### Step 2 — reverse conditioning
$P(X\mid I)=\dfrac{P(I\cap X)}{P(I)}$

Among the 60 interviewed, 40 had experience:
$P(X\mid I)=40/60=2/3\approx 0.667$

### Step 3 — why different?
Different denominators:
- $I\mid X$ conditions on the experience group (80)
- $X\mid I$ conditions on the interviewed group (60)

---

## Key takeaway (underline)
$P(A\mid B)$ is about the world *restricted to B*.

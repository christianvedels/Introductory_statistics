# Proof of the Central Limit Theorem (via the moment-generating function)

## Statement

Let $X_1, X_2, \ldots, X_n$ be a simple random sample with $E(X_i) = \mu$ and $Var(X_i) = \sigma^2 < \infty$. Then as $n \to \infty$:

$$Z_n = \frac{\bar{X} - \mu}{\sigma / \sqrt{n}} \xrightarrow{d} N(0, 1)$$

---

## The key tool: a transform that encodes a distribution

### Definition

The **moment-generating function** (MGF) of a random variable $Y$ is:

$$M_Y(t) = E\!\left[e^{tY}\right], \qquad t \in \mathbb{R}$$

where $t$ is a real-valued auxiliary argument (not a time or a data point — just a bookkeeping variable). The MGF is defined wherever the expectation is finite; for well-behaved distributions this holds for all $t$ in some open interval around zero.

**The MGF of the standard normal.** If $Y \sim N(0, 1)$, then:

$$M_Y(t) = e^{t^2/2}$$

Keep this in mind — we will arrive at exactly this expression at the end of the proof.

The name "moment-generating" comes from the fact that derivatives at zero recover the moments of $Y$:

$$M_Y^{(k)}(0) = E\!\left[Y^k\right]$$

This follows by differentiating $e^{tY}$ under the expectation and evaluating at $t = 0$. In particular:

| Derivative | Value at $t=0$ |
|---|---|
| $M_Y'(0)$ | $E[Y]$ |
| $M_Y''(0)$ | $E[Y^2]$ |

We can verify this for the normal: $M_Y'(t) = t\,e^{t^2/2}$, so $M_Y'(0) = 0 = E[Y]$. ✓  
And $M_Y''(t) = e^{t^2/2} + t^2 e^{t^2/2}$, so $M_Y''(0) = 1 = E[Y^2]$. ✓

Two facts we will use:

1. **Independence → product.** If $Y_1, \ldots, Y_n$ are independent, then  
   $M_{Y_1 + \cdots + Y_n}(t) = M_{Y_1}(t) \cdots M_{Y_n}(t)$  
   This follows directly from $E[e^{t(Y_1+\cdots+Y_n)}] = E[e^{tY_1}]\cdots E[e^{tY_n}]$ by independence.

2. **Convergence of MGFs → convergence in distribution.** If $M_{Z_n}(t) \to M_Z(t)$ for all $t$ near 0, then $Z_n \xrightarrow{d} Z$.  
   *(This is the continuity theorem — we take it on faith here.)*

---

## Proof

**Step 1 — Standardise the individual draws.**

Let $Y_i = \dfrac{X_i - \mu}{\sigma}$, so that $E(Y_i) = 0$ and $Var(Y_i) = 1$. Then:

$$Z_n = \frac{1}{\sqrt{n}} \sum_{i=1}^n Y_i$$

**Step 2 — Write the MGF of $Z_n$.**

Using Fact 1 and the scaling property of the MGF:

$$M_{Z_n}(t)
  = E\!\left[e^{t Z_n}\right]
  = E\!\left[e^{\,\frac{t}{\sqrt{n}}\sum_i Y_i}\right]
  = \prod_{i=1}^n E\!\left[e^{\,\frac{t}{\sqrt{n}} Y_i}\right]
  = \left[M_Y\!\left(\tfrac{t}{\sqrt{n}}\right)\right]^n$$

**Step 3 — Taylor-expand $M_Y$ around zero.**

Differentiating $M_Y(s) = E[e^{sY}]$:

- $M_Y(0) = 1$
- $M_Y'(0) = E[Y] = 0$
- $M_Y''(0) = E[Y^2] = Var(Y) = 1$

So by Taylor's theorem, for small $s$:

$$M_Y(s) = 1 + \underbrace{0}_{M_Y'(0)} \cdot s + \frac{1}{2}\underbrace{1}_{M_Y''(0)} \cdot s^2 + O(s^3) = 1 + \frac{s^2}{2} + O(s^3)$$

**Step 4 — Substitute $s = t/\sqrt{n}$.**

$$M_Y\!\left(\tfrac{t}{\sqrt{n}}\right) = 1 + \frac{t^2}{2n} + O\!\left(n^{-3/2}\right)$$

**Step 5 — Take the limit.**

$$M_{Z_n}(t) = \left(1 + \frac{t^2}{2n} + O\!\left(n^{-3/2}\right)\right)^{\!n} \;\xrightarrow{n\to\infty}\; e^{\,t^2/2}$$

using the standard limit $\lim_{n\to\infty}(1 + x/n)^n = e^x$.

**Step 6 — Identify the limit.**

The function $e^{t^2/2}$ is exactly the MGF of the standard normal $N(0,1)$.  
By Fact 2, $Z_n \xrightarrow{d} N(0,1)$. $\blacksquare$

---

## What this implies for $\bar{X}$

Since $Z_n = (\bar{X} - \mu)/(\sigma/\sqrt{n}) \xrightarrow{d} N(0,1)$, for large $n$:

$$\bar{X} \overset{a}{\sim} N\!\left(\mu,\, \frac{\sigma^2}{n}\right)$$

---

## What the proof actually uses

| Ingredient | Where it enters |
|---|---|
| $E(Y_i) = 0$, $Var(Y_i) = 1$ | Kills the first-order term in the Taylor expansion |
| Independence of the $Y_i$ | Lets the MGF of the sum factor into a product |
| $\sigma^2 < \infty$ | Guarantees the second-order Taylor term exists |
| Continuity theorem | Converts MGF convergence into distributional convergence |

The last row is the one black box. Every other step is elementary algebra.

---

## Why the result is remarkable

The proof never uses the *shape* of the distribution of $X$ — only its mean and variance. The bell shape of the limit is not a property of the data; it is a property of the averaging operation itself.

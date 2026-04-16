# Solution: Non-representative Bernoulli sample

## The setup

We want to estimate $p$ = the fraction of Danes who exercise regularly. Instead of sampling the general population, we recruit by standing outside a gym.

- $X_i = 1$: person exercises regularly
- $X_i = 0$: person does not
- $\alpha$: fraction of gym visitors who exercise regularly
- We are told $\alpha > p$ — gym-goers skew towards regular exercisers

---

## Part a) The population distribution and $E(X)$

In the **general population**, $X$ follows a Bernoulli distribution:

$$f_X(0) = 1 - p, \qquad f_X(1) = p$$

The expected value is:

$$E(X) = 0 \cdot f_X(0) + 1 \cdot f_X(1) = 0 \cdot (1-p) + 1 \cdot p = p$$

So $p$ is what we are trying to estimate. This is our target parameter.

---

## Part b) The conditional distribution among gym visitors

Let $Z_i$ denote that person $i$ is a gym visitor. Our sample is drawn uniformly from gym visitors, so every observation in our sample has $Z_i = z$ for some gym-visitor $z$.

Among gym visitors, the fraction who exercise regularly is $\alpha$, so:

$$f_{X_i \mid Z_i}(1 \mid z) = \alpha, \qquad f_{X_i \mid Z_i}(0 \mid z) = 1 - \alpha$$

for any gym visitor $z$.

**Are non-exercisers excluded?**

No. As long as $\alpha < 1$, non-exercisers have $f_{X_i \mid Z_i}(0 \mid z) = 1 - \alpha > 0$. They can appear in the sample — they are just *underrepresented* relative to the population, not fully excluded. This is a subtler problem than a sampling frame that excludes a group entirely (like using car registration records, which excludes non-car-owners completely).

---

## Part c) The marginal distribution of $X_i$ in the sample, bias, and the condition for representativeness

### Step 1 — Apply the law of total probability

Since every observation is drawn from gym visitors, we apply the marginal distribution formula:

$$f_{X_i}(x) = \sum_z f_{X_i \mid Z_i}(x \mid z) \cdot f_{Z_i}(z)$$

### Step 2 — Compute $f_{X_i}(1)$

Substituting $x = 1$:

$$f_{X_i}(1) = \sum_z f_{X_i \mid Z_i}(1 \mid z) \cdot f_{Z_i}(z) = \sum_z \alpha \cdot f_{Z_i}(z)$$

Since $\alpha$ does not depend on which gym visitor $z$ we are conditioning on, it factors out:

$$f_{X_i}(1) = \alpha \sum_z f_{Z_i}(z) = \alpha \cdot 1 = \alpha$$

### Step 3 — Compute $E(X_i)$ in the sample

$$E(X_i) = 0 \cdot (1-\alpha) + 1 \cdot \alpha = \alpha$$

### Step 4 — State the bias

The sample mean $\bar{X}$ is an unbiased estimator of $E(X_i) = \alpha$, **not** of $p$. The bias of $\bar{X}$ as an estimator of $p$ is:

$$\text{Bias} = E(\bar{X}) - p = \alpha - p > 0$$

The sample mean is **biased upward**: it systematically overestimates the fraction of regular exercisers in the population.

### Step 5 — The condition for representativeness

The sample is representative if and only if $\alpha = p$, i.e. gym visitors exercise regularly at exactly the same rate as the general population. Statistically, this is the condition that $X$ and $Z$ are **independent** — knowing that someone visits a gym gives no information about whether they exercise regularly.

In practice, this condition is implausible: going to the gym and exercising regularly are positively associated, so $\alpha > p$ and the sample will always overestimate $p$.

---

## Summary

| Quantity | Value |
|---|---|
| Population mean | $E(X) = p$ |
| Sample mean (in expectation) | $E(\bar{X}) = \alpha$ |
| Bias | $\alpha - p > 0$ (upward) |
| Condition for no bias | $\alpha = p$, i.e. $X \perp Z$ |

**Key takeaway:** Even when sampling is done correctly *within* the recruitment frame (gym visitors are sampled uniformly), a non-random frame introduces bias. The bias arises from the correlation between the recruitment mechanism ($Z$) and the variable of interest ($X$), not from any error in how individual observations are drawn.

---

## Sidenote: other descriptive measures are not recovered either

The mean is not the only thing that goes wrong. Consider the **variance**.

**In the population**, $X \sim \text{Bernoulli}(p)$, so:

$$Var(X) = p(1-p)$$

**In the sample**, $X_i \sim \text{Bernoulli}(\alpha)$, so the sample variance $S^2$ is an unbiased estimator of:

$$Var(X_i) = \alpha(1-\alpha)$$

The bias in the estimated variance is therefore:

$$\alpha(1-\alpha) - p(1-p)$$

Factoring:

$$= (\alpha - p)(1 - \alpha - p)$$

**The direction of the variance bias depends on $\alpha + p$:**

| Condition | Sign of bias | Interpretation |
|---|---|---|
| $\alpha + p < 1$ | Positive | Variance is *overestimated* |
| $\alpha + p > 1$ | Negative | Variance is *underestimated* |
| $\alpha + p = 1$ | Zero | Variance happens to be correct (by coincidence) |

Intuitively, the Bernoulli variance $q(1-q)$ is a concave function of $q$, maximised at $q = \tfrac{1}{2}$. Oversampling regular exercisers shifts $q$ from $p$ towards $\alpha$. If both $p$ and $\alpha$ are below $\tfrac{1}{2}$ (e.g. $p = 0.2$, $\alpha = 0.4$), then $\alpha$ is closer to $\tfrac{1}{2}$ and the variance is inflated. If both are above $\tfrac{1}{2}$ (e.g. $p = 0.6$, $\alpha = 0.8$), $\alpha$ is further from $\tfrac{1}{2}$ and the variance is deflated.

This matters because downstream quantities — standard errors, confidence intervals, hypothesis tests — all depend on the variance. A biased variance corrupts not just the point estimate but the entire inferential apparatus built on top of it.

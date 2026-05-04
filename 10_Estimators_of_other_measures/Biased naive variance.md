
*Here is a note on the proof presented in class the other day*

When $\mu$ is unknown, we estimate it using $\bar{X}$.

The natural estimator is

$$
b^2 = \frac{1}{n}\sum_{i=1}^n (X_i - \bar{X})^2.
$$

We want to show that

$$
E(b^2) = \frac{n-1}{n}\sigma^2.
$$

This means $b^2$ is biased downward because

$$
\frac{n-1}{n}\sigma^2 < \sigma^2.
$$

## Strategy

Define

$$
a := \sum_{i=1}^n (X_i - \bar{X})^2.
$$

Then we can write

$$
b^2 = \frac{1}{n}a.
$$

So instead of working directly with $b^2$, we first derive $E(a)$.

Once we know $E(a)$, we can use

$$
E(b^2)
=
E\left(\frac{1}{n}a\right)
=
\frac{1}{n}E(a).
$$

So the main task is to show that

$$
E(a) = (n-1)\sigma^2.
$$

## Step 1: Rewrite $a$
**We want to write this in a form, where we can easily take the expectation**

Start with

$$
a := \sum_{i=1}^n (X_i - \bar{X})^2.
$$

The problem is that $\bar{X}$ is random. It depends on the sample.

To make progress, rewrite each deviation from the sample mean by adding and subtracting the true mean $\mu$:

$$
\begin{split}
X_i - \bar{X} &=X_i-\mu+\mu-\bar X \\
&=(X_i-\mu)+(\mu-\bar X)
\\&=
(X_i - \mu) - (\bar{X} - \mu).
\end{split}
$$

Therefore,

$$
(X_i - \bar{X})^2
=
\left[(X_i - \mu) - (\bar{X} - \mu)\right]^2.
$$

Using the rule

$$
(c-d)^2 = c^2 - 2cd + d^2,
$$

we get

$$
(X_i - \bar{X})^2
=
(X_i-\mu)^2
-
2(X_i-\mu)(\bar{X}-\mu)
+
(\bar{X}-\mu)^2.
$$

Now sum over all observations:

$$
a
=
\sum_{i=1}^n (X_i - \bar{X})^2.
$$

So

$$
a
=
\sum_{i=1}^n (X_i-\mu)^2
-
\sum_{i=1}^n \left[2(\bar{X}-\mu) (X_i-\mu) \right]
+
\sum_{i=1}^n (\bar{X}-\mu)^2.
$$
Where we can move constants of of the summation in the second term to get
$$
a
=
\sum_{i=1}^n (X_i-\mu)^2
- 2(\bar{X}-\mu)
\sum_{i=1}^n  (X_i-\mu)
+
\sum_{i=1}^n (\bar{X}-\mu)^2.
$$


The last term does not depend on $i$, so

$$
\sum_{i=1}^n (\bar{X}-\mu)^2
=
n(\bar{X}-\mu)^2.
$$

Also,

$$
\sum_{i=1}^n (X_i-\mu)
=
\sum_{i=1}^n X_i - n\mu.
$$

Since $\bar X \equiv \frac{1}{n}\sum_{i=1}^n X_i$ it follows that

$$
\sum_{i=1}^n X_i = n\bar{X},
$$

we get

$$
\sum_{i=1}^n (X_i-\mu)
=
n\bar{X} - n\mu
=
n(\bar{X}-\mu).
$$

Substitute this into the expression for $a$:

$$
a
=
\sum_{i=1}^n (X_i-\mu)^2
-
2(\bar{X}-\mu)n(\bar{X}-\mu)
+
n(\bar{X}-\mu)^2.
$$

The middle term becomes

$$
-2n(\bar{X}-\mu)^2.
$$

So

$$
a
=
\sum_{i=1}^n (X_i-\mu)^2
-
2n(\bar{X}-\mu)^2
+
n(\bar{X}-\mu)^2.
$$

Combine the last two terms:

$$
a
=
\sum_{i=1}^n (X_i-\mu)^2
-
n(\bar{X}-\mu)^2.
$$

This is the key identity.

It says that the total squared deviation from the sample mean equals the total squared deviation from the true mean, minus a correction term corresponding to how far away our estimate of the mean is from the true mean.

## Step 2: Take expectations of $a$

Now take expectations on both sides:

$$
E(a)
=
E\left[
\sum_{i=1}^n (X_i-\mu)^2
-
n(\bar{X}-\mu)^2
\right].
$$

Using linearity of expectation we first get:

$$
E(a)
=
E\left[
\sum_{i=1}^n (X_i-\mu)^2
\right]
-
E\left[
n(\bar{X}-\mu)^2
\right].
$$

And then

$$
E(a)
=
\sum_{i=1}^n E[(X_i-\mu)^2]
-
nE\left[(\bar{X}-\mu)^2
\right].
$$



Now consider the first term. Since

$$
E[(X_i-\mu)^2] = Var(X_i) = \sigma^2,
$$

we get

$$
\sum_{i=1}^n E[(X_i-\mu)^2]
=
\sum_{i=1}^n \sigma^2
=
n\sigma^2.
$$

So the first term is

$$
E\left[
\sum_{i=1}^n (X_i-\mu)^2
\right]
=
n\sigma^2.
$$

Now consider the second term. We know from earlier that

$$
E[(\bar{X}-\mu)^2] = Var(\bar{X}).
$$

And since

$$
Var(\bar{X}) = \frac{\sigma^2}{n},
$$

we get

$$
nE[(\bar{X}-\mu)^2]
=
n \cdot \frac{\sigma^2}{n}
=
\sigma^2.
$$

Therefore,

$$
E\left[
n(\bar{X}-\mu)^2
\right]
=
\sigma^2.
$$

Putting the two parts together:

$$
E(a)
=
n\sigma^2 - \sigma^2.
$$

So

$$
E(a)
=
(n-1)\sigma^2.
$$

## Step 3: Use $E(a)$ to derive $E(b^2)$

Recall that

$$
b^2 = \frac{1}{n}a.
$$

Therefore,

$$
E(b^2)
=
E\left(\frac{1}{n}a\right).
$$

Move the constant $\frac{1}{n}$ outside the expectation:

$$
E(b^2)
=
\frac{1}{n}E(a).
$$

We have already shown that

$$
E(a) = (n-1)\sigma^2.
$$

Substitute this into the expression:

$$
E(b^2)
=
\frac{1}{n}(n-1)\sigma^2.
$$

So

$$
E(b^2)
=
\frac{n-1}{n}\sigma^2.
$$

Since

$$
\frac{n-1}{n} < 1,
$$

we have

$$
E(b^2) < \sigma^2.
$$

Therefore, $b^2$ is biased downward.

...but the great thing is we know the size of the bias!

## Intuition

The sample mean $\bar{X}$ is chosen from the data.

That means it is the point that makes the squared deviations in the sample as small as possible. So when we calculate deviations from $\bar{X}$, those deviations are a little too small on average.

This is why $b^2$ underestimates the true variance $\sigma^2$.

But the great thing is that we know exactly how much it underestimates it by.

The problem comes from estimating one extra thing from the data, namely the unknown mean $\mu$. Because we use the data to estimate $\mu$, we lose one degree of freedom. That is why the correction is to divide by $n-1$ instead of $n$.

## Extension: Correcting the bias

We have shown that

$$
E(a) = (n-1)\sigma^2.
$$

where

$$
a := \sum_{i=1}^n (X_i-\bar{X})^2.
$$

This tells us something very useful.

If dividing $a$ by $n$ gives us an estimator that is too small, then maybe we should divide by $n-1$ instead.

So define the alternative estimator

$$
S^2 = \frac{1}{n-1}a.
$$

Using the full expression for $a$, this is

$$
S^2
=
\frac{1}{n-1}
\sum_{i=1}^n (X_i-\bar{X})^2.
$$

We now want to show that this estimator is unbiased.

Start with

$$
S^2 = \frac{1}{n-1}a.
$$

Take expectations on both sides:

$$
E(S^2)
=
E\left(\frac{1}{n-1}a\right).
$$

Since $\frac{1}{n-1}$ is just a constant, we can move it outside the expectation:

$$
E(S^2)
=
\frac{1}{n-1}E(a).
$$

But we already showed that

$$
E(a) = (n-1)\sigma^2.
$$

Substitute this into the expression:

$$
E(S^2)
=
\frac{1}{n-1}(n-1)\sigma^2.
$$

The $(n-1)$ terms cancel:

$$
E(S^2)
=
\sigma^2.
$$

Therefore, $S^2$ is unbiased.

So the corrected estimator of the variance is

$$
S^2
=
\frac{1}{n-1}
\sum_{i=1}^n (X_i-\bar{X})^2.
$$

This is the usual sample variance.

The important point is that $n-1$ is not a random rule. It appears because estimating $\mu$ with $\bar{X}$ makes the squared deviations too small by exactly one unit of $\sigma^2$ in expectation.

## Further extension: Consistency

Bias is about finite samples.

Consistency is about what happens when the sample size becomes very large.

We want to know whether

$$
S^2
=
\frac{1}{n-1}
\sum_{i=1}^n (X_i-\bar{X})^2
$$

gets closer to $\sigma^2$ as $n$ grows.

The short argument is:

$$
\frac{1}{n-1}
\approx
\frac{1}{n}
$$

when $n$ is large.

Also, when $n$ is large, $\bar{X}$ gets close to $\mu$.

So

$$
S^2
=
\frac{1}{n-1}
\sum_{i=1}^n (X_i-\bar{X})^2
\approx
\frac{1}{n}
\sum_{i=1}^n (X_i-\mu)^2.
$$

By the law of large numbers,

$$
\frac{1}{n}
\sum_{i=1}^n (X_i-\mu)^2
\rightarrow
E[(X_i-\mu)^2]
=
\sigma^2.
$$

Therefore,

$$
S^2 \rightarrow \sigma^2.
$$

So $S^2$ is consistent.

In words: when the sample gets large, $\bar{X}$ becomes close to $\mu$, and the difference between dividing by $n-1$ and dividing by $n$ disappears.
# Confidence interval for μ: normal population, σ known

## Start here: what does a standard deviation tell us?

If $X \sim \mathcal{N}(\mu, \sigma^2)$, the standard deviation $\sigma$ describes the typical distance of an observation from the mean.

The sample mean $\bar{X}$ is also normally distributed, with standard deviation $\sigma/\sqrt{n}$ — its standard error. Larger $n$ makes $\bar{X}$ cluster more tightly around $\mu$.

## The shape of the interval

We want a symmetric interval centred on $\bar{X}$:

$$\hat{I} = \left[\bar{X} - k,\; \bar{X} + k\right]$$

**What is $k$?** It must be measured in the same units as $\bar{X}$, and the natural unit is the standard error. So $k = z \cdot \sigma/\sqrt{n}$ for some number $z$ of standard errors.

## How many standard errors?

We want the interval to contain $\mu$ with probability $1 - \alpha$. Since $\bar{X}$ is normally distributed around $\mu$ with standard error $\sigma/\sqrt{n}$, the interval $[\bar{X} - k, \bar{X} + k]$ captures $\mu$ whenever $\bar{X}$ itself is within $k$ of $\mu$ — i.e., whenever $\bar{X}$ falls in the central $(1-\alpha)$ portion of its distribution.

For a 95% interval, we need $z$ such that 95% of the normal distribution lies within $\pm z$ standard errors of the centre. That number is:

$$z = 1.96$$

*Why 1.96? It is the value that cuts off 2.5% in each tail of $\mathcal{N}(0,1)$, leaving 95% in the middle.*

## The result

Substituting $z = 1.96$:

$$\hat{I} = \left[\bar{X} - 1.96 \cdot \frac{\sigma}{\sqrt{n}},\;\; \bar{X} + 1.96 \cdot \frac{\sigma}{\sqrt{n}}\right]$$

For a general confidence level $1 - \alpha$, replace $1.96$ with $z_{1-\alpha/2}$:

$$\hat{I} = \left[\bar{X} \pm z_{1-\alpha/2} \cdot \frac{\sigma}{\sqrt{n}}\right]$$

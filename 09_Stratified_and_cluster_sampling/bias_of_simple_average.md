**Bias of the simple average under stratified sampling**

Let stratum $j$ have population size $N_j$ and true mean $\mu_j$, with $\sum_j N_j = N$ and $w_j = N_j/N$.

The population mean is $\mu = \sum_j w_j \mu_j$.

In a stratified sample, stratum $j$ contributes $n_j$ units, so the simple average is:

$$\bar{X} = \frac{1}{n}\sum_j n_j \bar{X}_j, \qquad \tilde{w}_j = \frac{n_j}{n}$$

Taking expectations ($E[\bar{X}_j] = \mu_j$):

$$E[\bar{X}] = \sum_j \tilde{w}_j \mu_j$$

The bias is therefore:

$$\text{Bias}(\bar{X}) = E[\bar{X}] - \mu = \sum_j (\tilde{w}_j - w_j)\mu_j$$

This is zero only when $\tilde{w}_j = w_j$ for all $j$, i.e. $n_j/n = N_j/N$ — proportional allocation. Otherwise the simple average over-weights strata sampled more heavily than their population share.

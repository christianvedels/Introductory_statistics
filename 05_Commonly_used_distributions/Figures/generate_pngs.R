# Generate PNG figures for lecture 05 slides
# Based on Statistics_S26_overleaf/Figures/6. Commonly used distributions.R

args <- commandArgs(trailingOnly = FALSE)
script_path <- sub("--file=", "", args[grep("--file=", args)])
outdir <- dirname(normalizePath(script_path))


#######
# (i) Example of a Bernoulli distribution
#######

p.bernoulli <- 0.4
x.bernoulli <- c(0, 1)
prob.bernoulli <- c(1 - p.bernoulli, p.bernoulli)

# Plot Bernoulli (combined label used in slides)
cdf <- c(0, cumsum(prob.bernoulli))
cdf.plot <- stepfun(x.bernoulli, cdf, f = 0)
png(file.path(outdir, "6. Bernoulli.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot.stepfun(cdf.plot,
             xlab = "",
             ylab = "",
             verticals = FALSE,
             do.points = TRUE,
             col = "blue",
             lwd = 2,
             main = "",
             pch = 16,
             axes = FALSE,
             frame.plot = 0)
axis(side = 1, pos = 0, cex.axis = 0.75)
segments(x0 = 0, y0 = 1, x1 = 1, y1 = 1, lty = 3, col = "black")
segments(x0 = 1, y0 = 0, x1 = 1, y1 = 1, lty = 3, col = "black")
cdf.at <- c(0, 1 - p.bernoulli, 1)
cdf.labels <- c("0", "1-p", "1")
axis(side = 2, at = cdf.at, labels = cdf.labels, pos = 0, las = 1, cex.axis = 0.75)
mtext(side = 2, text = "Cumulative distribution function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

# Plot Bernoulli CDF
png(file.path(outdir, "6. Bernoulli CDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot.stepfun(cdf.plot,
             xlab = "",
             ylab = "",
             verticals = FALSE,
             do.points = TRUE,
             col = "blue",
             lwd = 2,
             main = "",
             pch = 16,
             axes = FALSE,
             frame.plot = 0)
axis(side = 1, pos = 0, cex.axis = 0.75)
segments(x0 = 0, y0 = 1, x1 = 1, y1 = 1, lty = 3, col = "black")
segments(x0 = 1, y0 = 0, x1 = 1, y1 = 1, lty = 3, col = "black")
cdf.at <- c(0, 1 - p.bernoulli, 1)
cdf.labels <- c("0", "1-p", "1")
axis(side = 2, at = cdf.at, labels = cdf.labels, pos = 0, las = 1, cex.axis = 0.75)
mtext(side = 2, text = "Cumulative distribution function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

# Plot Bernoulli PDF
png(file.path(outdir, "6. Bernoulli PDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.bernoulli, prob.bernoulli,
     xlab = "",
     ylab = "",
     col = "blue",
     main = "",
     pch = 19,
     axes = FALSE,
     ylim = c(0, 0.8),
     xlim = c(-1, 2),
     frame.plot = 0
)
segments(x0 = 0, y0 = 0.4, x1 = 1, y1 = 0.4, lty = 3, col = "black")
segments(x0 = 1, y0 = 0.4, x1 = 1, y1 = 0, lty = 3, col = "black")
axis(side = 1, pos = 0, cex.axis = 0.75)
cdf.at <- c(0, 1 - p.bernoulli, p.bernoulli, 1)
cdf.labels <- c("0", "1-p", "p", "1")
axis(side = 2, at = cdf.at, labels = cdf.labels, pos = 0, las = 1, cex.axis = 0.75)
segments(x0 = -1, y0 = 0, x1 = 2, y1 = 0, col = "blue", lwd = 2)
points(x = 0, y = 0, pch = 21, col = "blue", bg = "white")
points(x = 1, y = 0, pch = 21, col = "blue", bg = "white")
mtext(side = 2, text = "Probability function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()


#######
# (ii) Example of a binomial distribution
#######

p.bernoulli <- 0.4
x.binomial <- seq(0, 4, 1)
prob.binomial <- (1 - p.bernoulli)^4
for (i in 1:4) {
  prob.binomial <- c(prob.binomial,
                     choose(4, i) * p.bernoulli^i * (1 - p.bernoulli)^(4 - i))
}

# Plot Binomial CDF
cdf <- c(0, cumsum(prob.binomial))
cdf.plot <- stepfun(x.binomial, cdf, f = 0)
png(file.path(outdir, "6. Binomial CDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot.stepfun(cdf.plot,
             xlab = "",
             ylab = "",
             verticals = FALSE,
             do.points = TRUE,
             col = "blue",
             lwd = 2,
             main = "",
             pch = 16,
             axes = FALSE,
             frame.plot = 0)
axis(side = 1, pos = 0, cex.axis = 0.75)
axis(side = 2, pos = 0, las = 1, cex.axis = 0.75)
mtext(side = 2, text = "Cumulative distribution function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

# Plot Binomial PDF
png(file.path(outdir, "6. Binomial PDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.binomial, prob.binomial,
     xlab = "",
     ylab = "",
     col = "blue",
     main = "",
     pch = 19,
     axes = FALSE,
     ylim = c(0, 0.8),
     xlim = c(-1, 5),
     frame.plot = 0
)
axis(side = 1, pos = 0, cex.axis = 0.75)
axis(side = 2, pos = 0, las = 1, cex.axis = 0.75)
segments(x0 = -1, y0 = 0, x1 = 5, y1 = 0, col = "blue", lwd = 2)
for (i in 0:4) {
  points(x = i, y = 0, pch = 21, col = "blue", bg = "white")
}
mtext(side = 2, text = "Probability function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()


#######
# (iii) Example of a hypergeometric distribution
#######

n.hyperg <- 3
M.hyperg <- 4
N.hyperg <- 10
x.hyperg <- seq(0, 3, 1)
prob.hyperg <- matrix(, nrow = 1, ncol = n.hyperg + 1)
for (i in 0:3) {
  prob.hyperg[i + 1] <- choose(M.hyperg, i) * choose(N.hyperg - M.hyperg, n.hyperg - i) / choose(N.hyperg, n.hyperg)
}

# Plot Hypergeometric CDF
cdf <- c(0, cumsum(prob.hyperg))
cdf.plot <- stepfun(x.hyperg, cdf, f = 0)
png(file.path(outdir, "6. Hypergeometric CDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot.stepfun(cdf.plot,
             xlab = "",
             ylab = "",
             verticals = FALSE,
             do.points = TRUE,
             col = "blue",
             lwd = 2,
             main = "",
             pch = 16,
             axes = FALSE,
             frame.plot = 0)
axis(side = 1, pos = 0, cex.axis = 0.75)
axis(side = 2, pos = 0, las = 1, cex.axis = 0.75)
mtext(side = 2, text = "Cumulative distribution function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

# Plot Hypergeometric PDF
png(file.path(outdir, "6. Hypergeometric PDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.hyperg, prob.hyperg,
     xlab = "",
     ylab = "",
     col = "blue",
     main = "",
     pch = 19,
     axes = FALSE,
     ylim = c(0, 0.6),
     xlim = c(-1, n.hyperg + 1),
     frame.plot = 0
)
axis(side = 1, pos = 0, cex.axis = 0.75)
axis(side = 2, pos = 0, las = 1, cex.axis = 0.75)
segments(x0 = -1, y0 = 0, x1 = n.hyperg + 1, y1 = 0, col = "blue", lwd = 2)
for (i in 0:n.hyperg) {
  points(x = i, y = 0, pch = 21, col = "blue", bg = "white")
}
mtext(side = 2, text = "Probability function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()


#######
# (iv) Example of a Poisson distribution
#######

lambda.poisson <- 4
x.poisson <- seq(0, 10, 1)
prob.poisson <- matrix(, nrow = 1, ncol = length(x.poisson))
for (i in 1:length(x.poisson)) {
  prob.poisson[i] <- lambda.poisson^(i - 1) * exp(-lambda.poisson) / factorial(i - 1)
}

# Plot Poisson CDF
cdf <- c(0, cumsum(prob.poisson))
cdf.plot <- stepfun(x.poisson, cdf, f = 0)
png(file.path(outdir, "6. Poisson CDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot.stepfun(cdf.plot,
             xlab = "",
             ylab = "",
             verticals = FALSE,
             do.points = TRUE,
             col = "blue",
             lwd = 2,
             main = "",
             pch = 16,
             axes = FALSE,
             ylim = c(0, 1),
             xlim = c(-1, max(x.poisson) + 1),
             frame.plot = 0)
axis(side = 1, pos = 0, cex.axis = 0.75)
axis(side = 2, pos = 0, las = 1, cex.axis = 0.75)
mtext(side = 2, text = "Cumulative distribution function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

# Plot Poisson PDF
png(file.path(outdir, "6. Poisson PDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.poisson, prob.poisson,
     xlab = "",
     ylab = "",
     col = "blue",
     main = "",
     pch = 19,
     axes = FALSE,
     ylim = c(0, 0.25),
     xlim = c(-1, max(x.poisson) + 1),
     frame.plot = 0
)
axis(side = 1, pos = 0, cex.axis = 0.75)
axis(side = 2, pos = 0, las = 1, cex.axis = 0.75)
segments(x0 = -1, y0 = 0, x1 = max(x.poisson) + 1, y1 = 0, col = "blue", lwd = 2)
for (i in 1:length(x.poisson)) {
  points(x = i, y = 0, pch = 21, col = "blue", bg = "white")
}
mtext(side = 2, text = "Probability density function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()


#######
# (v) Example of a normal distribution
#######

mu.normal <- 2
sigma2.normal <- 3
lim.normal <- round(3 * sqrt(sigma2.normal))
x.normal <- seq(mu.normal - lim.normal, mu.normal + lim.normal, length = 200 * lim.normal + 1)
prob.normal <- dnorm(x.normal, mean = mu.normal, sd = sqrt(sigma2.normal))
cdf.normal <- pnorm(x.normal, mean = mu.normal, sd = sqrt(sigma2.normal))

# Plot Normal CDF
png(file.path(outdir, "6. Normal CDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.normal, cdf.normal,
     xlab = "",
     ylab = "",
     type = "l",
     col = "blue",
     main = "",
     pch = 19,
     lwd = 2,
     axes = FALSE,
     ylim = c(0, 1),
     xlim = c(mu.normal - lim.normal, mu.normal + lim.normal),
     frame.plot = 0
)
axis(side = 1,
     at = c(seq(mu.normal - lim.normal, mu.normal + lim.normal, 2), 0),
     pos = 0,
     cex.axis = 0.75)
axis(side = 2, pos = 0, las = 1, cex.axis = 0.75)
segments(x0 = 0, y0 = 1, x1 = mu.normal + lim.normal, y1 = 1, col = "black", lty = 3)
mtext(side = 2, text = "Cumulative distribution function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

# Plot Normal PDF
png(file.path(outdir, "6. Normal PDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.normal, prob.normal,
     xlab = "",
     ylab = "",
     type = "l",
     col = "blue",
     main = "",
     pch = 19,
     lwd = 2,
     axes = FALSE,
     ylim = c(0, 0.3),
     xlim = c(mu.normal - lim.normal, mu.normal + lim.normal),
     frame.plot = 0
)
axis(side = 1,
     at = c(seq(mu.normal - lim.normal, mu.normal + lim.normal, 2), 0),
     pos = 0,
     cex.axis = 0.75)
axis(side = 2, pos = 0, las = 1, cex.axis = 0.75)
segments(x0 = x.normal[x.normal == mu.normal], y0 = 0,
         x1 = x.normal[x.normal == mu.normal], y1 = prob.normal[x.normal == mu.normal],
         col = "black", lty = 3)
mtext(side = 2, text = "Probability density function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()


# Standard normal distribution
mu.normal <- 0
sigma2.normal <- 1
lim.normal <- round(3 * sqrt(sigma2.normal))
x.normal <- seq(mu.normal - lim.normal, mu.normal + lim.normal, length = 200 * lim.normal + 1)
prob.normal <- dnorm(x.normal, mean = mu.normal, sd = sqrt(sigma2.normal))
cdf.normal <- pnorm(x.normal, mean = mu.normal, sd = sqrt(sigma2.normal))

# Plot Standard Normal CDF
png(file.path(outdir, "6. Standard normal CDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.normal, cdf.normal,
     xlab = "",
     ylab = "",
     type = "l",
     col = "blue",
     main = "",
     pch = 19,
     lwd = 2,
     axes = FALSE,
     ylim = c(0, 1),
     xlim = c(mu.normal - lim.normal, mu.normal + lim.normal),
     frame.plot = 0
)
axis(side = 1, pos = 0, cex.axis = 0.75)
axis(side = 2, pos = 0, las = 1, cex.axis = 0.75)
segments(x0 = 0, y0 = 1, x1 = mu.normal + lim.normal, y1 = 1, col = "black", lty = 3)
mtext(side = 2, text = "Cumulative distribution function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

# Plot Standard Normal PDF
png(file.path(outdir, "6. Standard normal PDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.normal, prob.normal,
     xlab = "",
     ylab = "",
     type = "l",
     col = "blue",
     main = "",
     pch = 19,
     lwd = 2,
     axes = FALSE,
     ylim = c(0, 0.45),
     xlim = c(mu.normal - lim.normal, mu.normal + lim.normal),
     frame.plot = 0
)
axis(side = 1, pos = 0, cex.axis = 0.75)
axis(side = 2, pos = 0, las = 1, cex.axis = 0.75)
mtext(side = 2, text = "Probability density function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()


# Symmetric standard normal (showing Phi(-a) = 1 - Phi(a))
a.normal <- -2
i1 <- x.normal >= mu.normal - lim.normal & x.normal <= a.normal
i2 <- x.normal <= mu.normal + lim.normal & x.normal >= -a.normal
png(file.path(outdir, "6. Symmetric standard normal PDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.normal, prob.normal,
     xlab = "",
     ylab = "",
     type = "l",
     col = "blue",
     main = "",
     pch = 19,
     lwd = 2,
     axes = FALSE,
     ylim = c(0, 0.45),
     xlim = c(mu.normal - lim.normal, mu.normal + lim.normal),
     frame.plot = 0
)
axis(side = 1, pos = 0, cex.axis = 0.75)
axis(side = 2, pos = 0, las = 1, cex.axis = 0.75)
polygon(c(mu.normal - lim.normal, x.normal[i1], a.normal), c(0, prob.normal[i1], 0),
        col = "red", density = 10, angle = 135, border = NA)
segments(x0 = a.normal, y0 = 0, x1 = a.normal, y1 = prob.normal[x.normal == a.normal], col = "black", lty = 3)
polygon(c(-a.normal, x.normal[i2], mu.normal + lim.normal), c(0, prob.normal[i2], 0),
        col = "red", density = 10, angle = 45, border = NA)
segments(x0 = -a.normal, y0 = 0, x1 = -a.normal, y1 = prob.normal[x.normal == -a.normal], col = "black", lty = 3)
text(x = (mu.normal - lim.normal - a.normal) / 2 + a.normal, y = prob.normal[x.normal == a.normal],
     substitute(Phi(a), list(a = a.normal)))
text(x = (mu.normal + lim.normal + a.normal) / 2 - a.normal, y = prob.normal[x.normal == -a.normal],
     substitute(1 - Phi(a), list(a = -a.normal)))
segments(x0 = a.normal, y0 = prob.normal[x.normal == a.normal], x1 = -a.normal, y1 = prob.normal[x.normal == -a.normal],
         col = "black", lty = 3)
text(x = 0.6, y = prob.normal[x.normal == a.normal] + 0.02,
     substitute(phi(a) == phi(b), list(a = a.normal, b = -a.normal)))
mtext(side = 2, text = "Probability density function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()


cat("All PNG figures generated successfully.\n")

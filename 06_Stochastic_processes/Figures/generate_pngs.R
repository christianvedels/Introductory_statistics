# Generate PNG figures for lecture 06 slides
# Stochastic processes: Bernoulli path, Binomial path, Wiener path

args <- commandArgs(trailingOnly = FALSE)
fp   <- sub("--file=", "", args[grep("--file=", args)])
script_path <- if (length(fp) > 0 && nchar(fp) > 0) {
  normalizePath(fp)                        # called via Rscript
} else {
  normalizePath(sys.frames()[[1]]$ofile)   # called via source()
}
outdir <- dirname(script_path)


#######
# (i) Example of a path of a Bernoulli process (p = 0.5)
#######

set.seed(42)
T.bern  <- 20
p.bern  <- 0.5
t.bern  <- seq_len(T.bern)
z.bern  <- rbinom(T.bern, size = 1, prob = p.bern)

png(file.path(outdir, "7. Bernoulli path.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(t.bern, z.bern,
     type = "n",
     xlab = "", ylab = "",
     axes = FALSE,
     xlim = c(0, T.bern + 1),
     ylim = c(-0.1, 1.3),
     frame.plot = FALSE)
# vertical lines from baseline to each point
segments(x0 = t.bern, y0 = 0, x1 = t.bern, y1 = z.bern,
         col = "blue", lwd = 1.5, lty = 3)
# filled circles at each value
points(t.bern, z.bern, pch = 16, col = "blue", cex = 1.2)
axis(side = 1, pos = 0, cex.axis = 0.75)
axis(side = 2, at = c(0, 1), labels = c("0", "1"),
     pos = 0, las = 1, cex.axis = 0.75)
mtext(side = 1, text = "t", line = 1.5, cex = 0.9)
mtext(side = 2, text = expression(Z[t]), line = 2, cex = 0.9)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()


#######
# (ii) Example of a path of a binomial process (p = 0.5)
#######

# Reuse the same Bernoulli draws for consistency
x.binom <- c(0, cumsum(z.bern))
t.binom <- 0:T.bern

png(file.path(outdir, "7. Binomial path.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
# step function: X_t stays constant until next event
plot(t.binom, x.binom,
     type = "s",
     xlab = "", ylab = "",
     col = "blue",
     lwd = 2,
     axes = FALSE,
     xlim = c(0, T.bern + 1),
     ylim = c(0, max(x.binom) + 1),
     frame.plot = FALSE)
points(t.binom, x.binom, pch = 16, col = "blue", cex = 0.9)
axis(side = 1, pos = 0, cex.axis = 0.75)
axis(side = 2, pos = 0, las = 1, cex.axis = 0.75)
mtext(side = 1, text = "t", line = 1.5, cex = 0.9)
mtext(side = 2, text = expression(X[t]), line = 2, cex = 0.9)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()


#######
# (iii) Example of paths of a Gaussian random walk and a Wiener process
#        (mu = 0, sigma^2 = 4)
#######

mu    <- 0
sigma <- 2   # sigma^2 = 4

T.max <- 20

# Gaussian random walk: increments at integer steps
set.seed(7)
T.rw   <- T.max
t.rw   <- 0:T.rw
inc.rw <- rnorm(T.rw, mean = mu, sd = sigma)
x.rw   <- c(0, cumsum(inc.rw))

# Wiener process: increments at fine grid dt = 0.1
set.seed(99)
dt      <- 0.1
t.wp    <- seq(0, T.max, by = dt)
n.wp    <- length(t.wp) - 1
inc.wp  <- rnorm(n.wp, mean = mu * dt, sd = sigma * sqrt(dt))
x.wp    <- c(0, cumsum(inc.wp))

y.range <- range(c(x.rw, x.wp))
y.pad   <- diff(y.range) * 0.1

png(file.path(outdir, "7. Wiener path.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 3.5, 0, 0) + 0.5)
plot(t.wp, x.wp,
     type = "l",
     col  = "orange",
     lwd  = 1.5,
     xlab = "", ylab = "",
     axes = FALSE,
     xlim = c(0, T.max),
     ylim = c(y.range[1] - y.pad, y.range[2] + y.pad),
     frame.plot = FALSE)
lines(t.rw, x.rw, col = "blue", lwd = 2, type = "s")
points(t.rw, x.rw, pch = 16, col = "blue", cex = 0.8)
abline(h = 0, lty = 3, col = "grey60")
axis(side = 1, pos = y.range[1] - y.pad, cex.axis = 0.75)
axis(side = 2, pos = 0, las = 1, cex.axis = 0.75)
mtext(side = 1, text = "t", line = 1.5, cex = 0.9)
mtext(side = 2, text = expression(X[t]), line = 2.5, cex = 0.9)
legend("topleft",
       legend = c("Gaussian random walk", "Wiener process"),
       col    = c("blue", "orange"),
       lwd    = c(2, 1.5),
       lty    = c(1, 1),
       bty    = "n",
       cex    = 0.85)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()


cat("All PNG figures generated successfully.\n")

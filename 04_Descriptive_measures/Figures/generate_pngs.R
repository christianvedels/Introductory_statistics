# Generate PNG figures for lecture 04 slides
# Based on Statistics_S26_overleaf/Figures/5. Descriptive measures.R

args <- commandArgs(trailingOnly = FALSE)
script_path <- sub("--file=", "", args[grep("--file=", args)])
outdir <- dirname(normalizePath(script_path))

#######
# (i) Quantiles discrete (CDF of fair coin toss)
#######

x.discrete <- seq(1, 2, 1)
prob <- matrix(1/2, 1, 2)
cdf <- c(0, cumsum(prob))
cdf.plot <- stepfun(x.discrete, cdf, f = 0)

png(file.path(outdir, "5. Quantiles discrete.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot.stepfun(cdf.plot, xlab = "", ylab = "", verticals = FALSE,
             do.points = TRUE, col = "blue", lwd = 2, main = "",
             pch = 16, axes = FALSE, frame.plot = 0)
axis(side = 1, pos = 0, cex.axis = 0.75)
segments(x0 = 0, y0 = 0.5, x1 = 1, y1 = 0.5, lty = 3, col = "black")
segments(x0 = 1, y0 = 0.5, x1 = 1, y1 = 0, lty = 3, col = "black")
segments(x0 = 0, y0 = 1, x1 = 2, y1 = 1, lty = 3, col = "black")
segments(x0 = 2, y0 = 1, x1 = 2, y1 = 0, lty = 3, col = "black")
segments(x0 = 0, y0 = 0.25, x1 = 2, y1 = 0.25, lty = 3, col = "red")
mtext(side = 1, text = "Value of toss of coin", line = 2)
cdf.labels <- c(0, 0.25, 0.5, 1)
axis(side = 2, at = cdf.labels, pos = 0, cex.axis = 0.75)
mtext(side = 2, text = "Cumulative distribution function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

#######
# (ii) Median (PDF of uniform on [10, 20])
#######

x.cont <- seq(0, 30, length = 301)
prob <- matrix(0, 1, 301)
a <- rbind(x.cont, prob, prob, prob)
a[2, a[1, ] >= 10] <- 1 / 10
a[2, a[1, ] < 10] <- NA
a[2, a[1, ] > 20] <- NA
prob <- a[2, ]
a[3, a[1, ] >= 10] <- NA
prob.1 <- a[3, ]
a[4, a[1, ] <= 20] <- NA
prob.2 <- a[4, ]

png(file.path(outdir, "5. Median.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.cont, prob, xlab = "", ylab = "", type = "l", lwd = 2,
     col = "blue", main = "", pch = 16, axes = FALSE,
     ylim = c(0, 0.2), frame.plot = 0)
lines(x.cont, prob.1, lwd = 2, col = "blue")
lines(x.cont, prob.2, lwd = 2, col = "blue")
segments(x0 = 10, y0 = 0, x1 = 10, y1 = 0.1, lty = 3, col = "black")
segments(x0 = 20, y0 = 0, x1 = 20, y1 = 0.1, lty = 3, col = "black")
segments(x0 = 15, y0 = 0, x1 = 15, y1 = 0.1, lty = 3, col = "black")
axis(side = 1, pos = 0, cex.axis = 0.75)
mtext(side = 1, text = "median", cex = 0.75, line = -0.5)
mtext(side = 1, text = "Value of X", line = 2)
cdf.labels <- c(0, 0.1, 0.2)
axis(side = 2, at = cdf.labels, pos = 0, cex.axis = 0.75)
mtext(side = 2, text = "Probability density function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

#######
# (iii) Multiple medians — PDF
#######

x.cont <- seq(0, 5, length = 501)
prob <- matrix(NA, 1, 501)
a <- rbind(x.cont, prob, prob, prob)
a[2, 1 <= a[1, ] & a[1, ] < 2] <- 0.5
a[2, 3 <= a[1, ] & a[1, ] < 4] <- 0.5
prob <- a[2, ]
a[3, a[1, ] < 1] <- 0
a[3, 2 < a[1, ] & a[1, ] < 3] <- 0
a[3, a[1, ] > 4] <- 0
prob.1 <- a[3, ]

png(file.path(outdir, "5. Multiple medians PDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.cont, prob, xlab = "", ylab = "", type = "l", lwd = 2,
     col = "blue", main = "", pch = 16, axes = FALSE,
     ylim = c(0, 1), frame.plot = 0)
lines(x.cont, prob.1, lwd = 2, col = "blue")
segments(x0 = 1, y0 = 0, x1 = 1, y1 = 0.5, lty = 3, col = "black")
segments(x0 = 2, y0 = 0, x1 = 2, y1 = 0.5, lty = 3, col = "black")
segments(x0 = 3, y0 = 0, x1 = 3, y1 = 0.5, lty = 3, col = "black")
segments(x0 = 4, y0 = 0, x1 = 4, y1 = 0.5, lty = 3, col = "black")
segments(x0 = 0, y0 = 0.5, x1 = 1, y1 = 0.5, lty = 3, col = "black")
segments(x0 = 2, y0 = 0.5, x1 = 3, y1 = 0.5, lty = 3, col = "black")
segments(x0 = 2, y0 = 0, x1 = 3, y1 = 0, lty = 1, lwd = 3, col = "red")
axis(side = 1, pos = 0, cex.axis = 0.75)
mtext(side = 1, text = "Value of X", line = 2)
cdf.labels <- c(0, 0.5, 1)
axis(side = 2, at = cdf.labels, pos = 0, cex.axis = 0.75)
mtext(side = 2, text = "Probability density function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

#######
# (iv) Multiple medians — CDF
#######

prob[is.na(prob)] <- 0
cdf <- c(0, cumsum(prob)) / 100
cdf.plot <- stepfun(x.cont, cdf, f = 0)

png(file.path(outdir, "5. Multiple medians CDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot.stepfun(cdf.plot, xlab = "", ylab = "", verticals = FALSE,
             do.points = FALSE, col = "blue", lwd = 2, main = "",
             pch = 16, axes = FALSE, frame.plot = 0)
axis(side = 1, pos = 0, cex.axis = 0.75)
segments(x0 = 0, y0 = 0.5, x1 = 2, y1 = 0.5, lty = 3, col = "black")
segments(x0 = 2, y0 = 0.5, x1 = 2, y1 = 0, lty = 3, col = "black")
segments(x0 = 3, y0 = 0.5, x1 = 3, y1 = 0, lty = 3, col = "black")
segments(x0 = 0, y0 = 1, x1 = 4, y1 = 1, lty = 3, col = "black")
segments(x0 = 4, y0 = 1, x1 = 4, y1 = 0, lty = 3, col = "black")
segments(x0 = 2, y0 = 0, x1 = 3, y1 = 0, lty = 1, lwd = 3, col = "red")
mtext(side = 1, text = "Value of X", line = 2)
cdf.labels <- c(0, 0.5, 1)
axis(side = 2, at = cdf.labels, pos = 0, cex.axis = 0.75)
mtext(side = 2, text = "Cumulative distribution function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

#######
# (v) Bimodal distribution
#######

x <- seq(0, 8, len = 201)
f <- function(x, p1 = 0.5, p2 = 1 - p1, m1, m2)
  p1 * dnorm(x, m1) + p2 * dnorm(x, m2)
pdf_vals <- f(x, p1 = 0.5, m1 = 2, m2 = 6)

png(file.path(outdir, "5. Bimodal.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x, pdf_vals, xlab = "", ylab = "", type = "l", lwd = 2,
     col = "blue", main = "", pch = 16, axes = FALSE,
     ylim = c(0, 0.2), frame.plot = 0)
axis(side = 1, pos = 0, cex.axis = 0.75)
mtext(side = 1, text = "Value of X", line = 2)
cdf.labels <- c(0, 0.1, 0.2)
axis(side = 2, at = cdf.labels, pos = 0, cex.axis = 0.75)
mtext(side = 2, text = "Probability density function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

cat("All 5 PNG figures generated successfully.\n")

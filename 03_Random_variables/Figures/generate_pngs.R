# Generate PNG figures for lecture 03 slides
# Based on Statistics_S26_overleaf/Figures/4. Random variables.R

args <- commandArgs(trailingOnly = FALSE)
script_path <- sub("--file=", "", args[grep("--file=", args)])
outdir <- dirname(normalizePath(script_path))

# (i) Discrete CDF (roll of a dice)
x.discrete <- seq(1, 6, 1)
prob <- matrix(1/6, 1, 6)
cdf <- c(0, cumsum(prob))
cdf.plot <- stepfun(x.discrete, cdf, f = 0)

png(file.path(outdir, "4. Discrete CDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot.stepfun(cdf.plot, xlab = "", ylab = "", verticals = FALSE,
             do.points = TRUE, col = "blue", lwd = 2, main = "",
             pch = 16, axes = FALSE, frame.plot = 0)
axis(side = 1, pos = 0, cex.axis = 0.75)
mtext(side = 1, text = "Value of roll of dice", line = 2)
cdf.labels <- formatC(cdf, digits = 2, format = "f")
axis(side = 2, at = cdf.labels, pos = 0, cex.axis = 0.75)
mtext(side = 2, text = "Cumulative distribution function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

# (ii) Continuous CDF
x.cont <- seq(0, 30, length = 301)
prob <- matrix(0, 1, 301)
a <- rbind(x.cont, prob)
a[2, a[1, ] > 10] <- 1 / 10
a[2, a[1, ] > 20] <- 0
prob <- a[2, ]
cdf <- cumsum(prob) / 10

png(file.path(outdir, "4. Continuous CDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.cont, cdf, xlab = "", ylab = "", type = "l", lwd = 2,
     col = "blue", main = "", pch = 16, axes = FALSE, frame.plot = 0)
axis(side = 1, pos = 0, cex.axis = 0.75)
segments(x0 = 20, y0 = 0, x1 = 20, y1 = 1, lty = 3, col = "black")
segments(x0 = 20, y0 = 1, x1 = 0, y1 = 1, lty = 3, col = "black")
mtext(side = 1, text = "Output (tons)", line = 2)
cdf.labels <- seq(0, 1, 0.1)
axis(side = 2, at = cdf.labels, pos = 0, cex.axis = 0.75)
mtext(side = 2, text = "Cumulative distribution function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

# (iii) Continuous PDF
a <- rbind(x.cont, prob, prob, prob)
a[2, a[1, ] < 10] <- NA
a[2, a[1, ] > 20] <- NA
prob.1 <- a[2, ]
a[3, a[1, ] >= 10] <- NA
a[3, a[1, ] > 20] <- 0
prob.2 <- a[3, ]

png(file.path(outdir, "4. Continuous PDF.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.cont, prob.2, xlab = "", ylab = "", type = "l", lwd = 2,
     col = "blue", main = "", pch = 16, axes = FALSE,
     ylim = c(0, 0.2), frame.plot = 0)
lines(x.cont, prob.1, lwd = 2, col = "blue")
segments(x0 = 10, y0 = 0, x1 = 10, y1 = 0.1, lty = 3, col = "black")
segments(x0 = 20, y0 = 0, x1 = 20, y1 = 0.1, lty = 3, col = "black")
segments(x0 = 0, y0 = 0.1, x1 = 10, y1 = 0.1, lty = 3, col = "black")
axis(side = 1, pos = 0, cex.axis = 0.75)
mtext(side = 1, text = "Output (tons)", line = 2)
cdf.labels <- c(0, 0.1, 0.2)
axis(side = 2, at = cdf.labels, pos = 0, cex.axis = 0.75)
mtext(side = 2, text = "Probability density function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

# (iv) Continuous PDF total area
png(file.path(outdir, "4. Continuous PDF total area.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.cont, prob.2, xlab = "", ylab = "", type = "l", lwd = 2,
     col = "blue", main = "", pch = 16, axes = FALSE,
     ylim = c(0, 0.2), frame.plot = 0)
lines(x.cont, prob.1, lwd = 2, col = "blue")
segments(x0 = 10, y0 = 0, x1 = 10, y1 = 0.1, lty = 3, col = "black")
segments(x0 = 20, y0 = 0, x1 = 20, y1 = 0.1, lty = 3, col = "black")
segments(x0 = 0, y0 = 0.1, x1 = 10, y1 = 0.1, lty = 3, col = "black")
rect(xleft = 10, ybottom = 0, xright = 20, ytop = 0.1, density = 5, col = "blue", lwd = 1, border = NA)
text(x = 15, y = 0.05, "1", cex = 1.25)
axis(side = 1, pos = 0, cex.axis = 0.75)
mtext(side = 1, text = "Output (tons)", line = 2)
cdf.labels <- c(0, 0.1, 0.2)
axis(side = 2, at = cdf.labels, pos = 0, cex.axis = 0.75)
mtext(side = 2, text = "Probability density function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

# (v) Continuous PDF partial area
png(file.path(outdir, "4. Continuous PDF partial area.png"), width = 600, height = 450, res = 100)
par(mar = c(2.5, 2.5, 0, 0) + 0.5)
plot(x.cont, prob.2, xlab = "", ylab = "", type = "l", lwd = 2,
     col = "blue", main = "", pch = 16, axes = FALSE,
     ylim = c(0, 0.2), frame.plot = 0)
lines(x.cont, prob.1, lwd = 2, col = "blue")
segments(x0 = 10, y0 = 0, x1 = 10, y1 = 0.1, lty = 3, col = "black")
segments(x0 = 20, y0 = 0, x1 = 20, y1 = 0.1, lty = 3, col = "black")
segments(x0 = 0, y0 = 0.1, x1 = 10, y1 = 0.1, lty = 3, col = "black")
rect(xleft = 10, ybottom = 0, xright = 17, ytop = 0.1, density = 5, col = "blue", lwd = 1, border = NA)
segments(x0 = 17, y0 = 0, x1 = 17, y1 = 0.1, lty = 3, col = "black")
text(x = 13.5, y = 0.05, labels = expression(F(17)), cex = 1.25)
xlab <- c(seq(0, 30, 5), 17)
axis(side = 1, pos = 0, at = xlab, cex.axis = 0.75)
mtext(side = 1, text = "Output (tons)", line = 2)
cdf.labels <- c(0, 0.1, 0.2)
axis(side = 2, at = cdf.labels, pos = 0, cex.axis = 0.75)
mtext(side = 2, text = "Probability density function", line = 2)
par(mar = c(5, 4, 4, 2) + 0.1)
dev.off()

cat("All 5 PNG figures generated successfully.\n")

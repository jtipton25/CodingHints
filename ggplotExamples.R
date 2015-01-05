##
## Commonly done ggplot examples from A HopStat and Jump Away blog
##


##
## Create data frame with two groups
##

library(ggplot2)
set.seed(20141016)
data = data.frame(x = rnorm(1000, mean = 6))
data$group1 = rbinom(n = 1000, size = 1, prob = 0.5)
data$y = data$x * 5 + rnorm(1000)
data$group2 = runif(1000) > 0.2

## Construct a ggplot object
g = ggplot(data, aes(x = x, y = y)) + geom_point()

## Plot the ggplot example
g

## Color the plot by the grouping variable, adding the aesthetic
g + aes(colour = group1)

## Color the plot by the grouping variable, adding the aesthetic
g + aes(colour = factor(group1))

## Color the plot by the labeling group one, adding the aesthetic
g + aes(colour = group2)

## This fails because the aesthetic that we are calling is not part of the data frame used to create g
data$newcol = rbinom(n = nrow(data), size = 2, prob = 0.5)
g + aes(colour = factor(newcol))

## If we create a new ggplot object with the new variable it works
g2 = ggplot(data, aes(x = x, y = y)) + geom_point()
g2 + aes(colour = factor(newcol))

##
## Scatter plot with a smoother
##

g2 + geom_smooth()

## Smoother without standard error bars
g2 + geom_smooth(se = FALSE)

## A smoother for each variable
g2 + geom_smooth(aes(colour = factor(newcol)), se = FALSE)

##
## Faceting - Plots conditional on variables
##

g + facet_wrap(~ group1)

## Conditioning on a different variable
g + facet_wrap(~ group2)

## Conditioning on multiple variables
g + facet_wrap(group2 ~ group1)
g + facet_wrap(group1 ~ group2)
g + facet_wrap( ~ group2 + group1)

## Spaghetti plot with smoother
##
## Simulate longitudinal data
##

library(MASS)
library(nlme)

### set number of individuals
n <- 200

### average intercept and slope
beta0 <- 1.0
beta1 <- 6.0

### true autocorrelation
ar.val <- 0.4

### true error SD, intercept SD, slope SD, and intercept-slope cor
sigma <- 1.5
tau0 <- 2.5
tau1 <- 2.0
tau01 <- 0.3

### maximum number of possible observations
m <- 10

### simulate number of observations for each individual
p <- round(runif(n, 4, m))

### simulate observation moments (assume everybody has 1st obs)
obs <- unlist(sapply(p, function(x) c(1, sort(sample(2:m, x - 1, 
                                                     replace = FALSE)))))

### set up data frame
dat <- data.frame(id = rep(1:n, times = p), obs = obs)

### simulate (correlated) random effects for intercepts and slopes
mu <- c(0,0)
S <- matrix(c(1, tau01, tau01, 1), nrow=2)
tau <- c(tau0, tau1)
S <- diag(tau) %*% S %*% diag(tau)
U <- mvrnorm(n, mu=mu, Sigma=S)

### simulate AR(1) errors and then the actual outcomes
dat$eij <- unlist(sapply(p, function(x) arima.sim(model = list(ar = ar.val), 
                                                  n = x) * sqrt(1 - ar.val^2) *
                                                  sigma))
dat$yij <- (beta0 + rep(U[, 1], times = p)) + 
          (beta1 + rep(U[, 2], times = p)) * log(dat$obs) + dat$eij


## Add an alpha level (highlights 10% of the data) to the plotting lines for the next plot (this must be done before the plot is created)
## tspag will be the template plot and will create a spaghetti plot spag with each color representing an id
library(plyr)
dat = ddply(dat, .(id), function(x){
      x$alpha = ifelse(runif(n = 1) > 0.9, 1, 0.1)
      x$grouper = factor(rbinom(n = 1, size = 3 ,prob = 0.5), levels = 0:3)
      x
})
tspag = ggplot(dat, aes(x = obs, y = yij)) + geom_line() + 
    guides(colour=FALSE) + xlab("Observation Time Point") +  ylab("Y")
spag = tspag + aes(colour = factor(id))
spag

## Group to id but highlight just a few using the alpha variabe (approximately 10% of the data)
bwspag = tspag + aes(alpha = alpha, group = factor(id)) + guides(alpha = FALSE)
bwspag

## Each spaghetti plot by group id
spag + facet_wrap(~ grouper)

## Spaghetti plot with overall smoother
sspag = spag + geom_smooth(se = FALSE, colour = "black", size = 2)
sspag

## Plot each by group id with a smoother
sspag + facet_wrap(~ grouper)

## Same plot but only the highlighted ~10% as per the alpha variable
bwspag + facet_wrap(~ grouper)

## produces a smoother for each curve...
bwspag + facet_wrap(~ grouper) + geom_smooth(se = FALSE, colour = "red")

## This can be fixed by using the group aesthetic
bwspag + facet_wrap(~ grouper) + geom_smooth(aes(group = 1), se = FALSE, 
				colour = "red", size  = 2)

##
## How to save a plot twice, as a pdf and png
##

pdf(tempfile())
print({g1 = g + aes(colour = group1)})
print({g1fac = g + aes(colour = factor(group1))})
print({g2 = g + aes(colour = group2)})
dev.off()

png(tempfile(), res = 300, height =7, width= 7, units = "in")
print(g2)
dev.off()


##
## ggplot examples 2
##

## From R-bloggers

library(ggplot2)
set.seed(20141106)
data = data.frame(x = rnorm(1000, mean=6), 
                  batch = factor(rbinom(1000, size=4, prob = 0.5)))
data$group1 = 1-rbeta(1000, 10, 2)
mat = model.matrix(~ batch, data=data)
mat = mat[, !colnames(mat) %in% "(Intercept)"]
betas = rbinom(ncol(mat), size=20, prob = 0.5)
data$quality = rowSums(t(t(mat) * sample(-2:2)))
data$dec.quality = cut(data$quality, 
                       breaks = unique(quantile(data$quality, 
                                                probs = seq(0, 1, by=0.1))),
                                                include.lowest = TRUE)

batch.effect = t(t(mat) * betas)
batch.effect = rowSums(batch.effect)
## Added in batch.effects and quality 
data$y = data$x * 5 + rnorm(1000) + batch.effect  + 
  data$quality * rnorm(1000, sd = 2)

data$group2 = runif(1000)

## Scatter Plot of y ~ x
g = ggplot(data, aes(x = x, y=y)) + geom_point()
print(g)

## Color by a 3rd discrete variable, the batch effect
print({ g + aes(colour=batch)})

## Color by a 3rd continuous variable, quality
print({ gcol = g + aes(colour=quality)})

## Color by a 3rd continuous variable, quality with a different color scale
print({ gcol + scale_colour_gradient(low = "red", high="blue") })

## break into more categories for better seperation
print({ gcol_grad = gcol + 
	scale_colour_gradient2(low = "red", 
			mid = "gray", high="blue") })

## Break the continuous variable into discrete classes
print({ gcol_dec = g + aes(colour=dec.quality) })

## Scattterplot with coloring by a 3rd continuous variable faceted by a 4th discrete variable
print({ gcol_grad + facet_wrap(~ batch )})

##
## Histograms
##

## Simulate longitudinal data
library(MASS)
library(nlme)

### set number of individuals
n <- 200

### average intercept and slope
beta0 <- 1.0
beta1 <- 6.0

### true autocorrelation
ar.val <- 0.4

### true error SD, intercept SD, slope SD, and intercept-slope cor
sigma <- 1.5
tau0 <- 2.5
tau1 <- 2.0
tau01 <- 0.3

### maximum number of possible observations
m <- 10

### simulate number of observations for each individual
p <- round(runif(n, 4, m))

### simulate observation moments (assume everybody has 1st obs)
obs <- unlist(sapply(p, function(x) c(1, sort(sample(2:m, x - 1, 
                                                     replace = FALSE)))))

### set up data frame
dat <- data.frame(id = rep(1:n, times = p), obs = obs)

### simulate (correlated) random effects for intercepts and slopes
mu <- c(0, 0)
S <- matrix(c(1, tau01, tau01, 1), nrow = 2)
tau <- c(tau0, tau1)
S <- diag(tau) %*% S %*% diag(tau)
U <- mvrnorm(n, mu = mu, Sigma = S)

### simulate AR(1) errors and then the actual outcomes
dat$eij <- unlist(sapply(p, function(x) arima.sim(
              model = list(ar = ar.val), n = x) * sqrt(1 - ar.val^2) * sigma))
dat$yij <- (beta0 + rep(U[, 1], times = p)) + 
          (beta1 + rep(U[, 2], times = p)) * log(dat$obs) + dat$eij


## Add an alpha level (highlights 10% of the data) to the plotting lines for the next plot (this must be done before the plot is created)
## tspag will be the template plot and will create a spaghetti plot spag with each color representing an id
library(plyr)
dat = ddply(dat, .(id), function(x){
x$alpha = ifelse(runif(n = 1) > 0.9, 1, 0.1)
x$grouper = factor(rbinom(n = 1, size = 3 ,prob = 0.5), levels = 0:3)
x
})
tspag = ggplot(dat, aes(x = obs, y = yij)) + 
geom_line() + guides(colour = FALSE) + xlab("Observation Time Point") +
      ylab("Y")
spag = tspag + aes(colour = factor(id))
spag

## Histograms stack on top of each other

library(plyr)
g = ggplot(data = dat, aes(x = yij, fill = factor(id))) + guides(fill = FALSE)
ghist = g + geom_histogram(binwidth = 3) 
print(ghist)

## Histograms don't stack on one another, but are hard to see
ghist =  g+ geom_histogram(binwidth = 3, position ="identity") 
print(ghist)

## Using the %+% operator
## The %+% operator allows you to reset what dataset is in the ggplot2 object. The data must have the same components (e.g. variable names); I think this is most useful for plotting subsets of data.

nobs = 10
npick = 5

## Let's plot the density of (5) people people with (10) or more observations both using geom_density and geom_line(stat = "density"). We will also change the binwidth:

tab = table(dat$id)
ids = names(tab)[tab != nobs]
ids = sample(ids, npick)
sub = dat[ dat$id %in% ids, ]
ghist = g + geom_histogram(binwidth = 5, position = "identity") 
ghist %+% sub

## Overlaid histograms with alpha blending on the subset
ggroup = ggplot(data = sub, aes(x = yij, fill = factor(id))) + 
				guides(fill = FALSE)
grouphist = ggroup + geom_histogram(binwidth = 5, 
				position = "identity", alpha = 0.33) 
grouphist

## Overlaid histograms with alpha blending on the full dataset
ggroup = ggplot(data = dat, aes(x = yij, fill = factor(grouper))) +
				 guides(fill = FALSE)
grouphist = ggroup + geom_histogram(binwidth = 5, position = 
					"identity", alpha = 0.33) 
grouphist

## Density estimates using kernel density estimation
g = ggplot(data = dat, aes(x = yij, fill = factor(id))) +
			guides(fill = FALSE)
print({gdens = g + geom_density() })

## Different colors per perosn/group/id
g = ggplot(data = dat, aes(x = yij, colour = factor(id))) +
			guides(colour = FALSE)
print({gdens = g + geom_density() })

## Remove the bottom line
print({gdens2 = g + geom_line(stat = "density")})

## Set the line fill <- lines have no fill so it sets colors to black
gdens3 = ggplot(data = dat, aes(x = yij, fill = factor(id))) + 
		geom_line(stat = "density") + guides(colour = FALSE)
print({gdens3})

## Overlapping densities with alpha blending
print({ group_dens = ggroup + geom_density(alpha = 0.3) })

## Show with lines <- lines don't take fill
print({group_dens2 = ggroup + geom_line(stat ="density")})

## Give the lines color
print({group_dens2 = ggroup + geom_line(aes(colour = grouper), 
	stat = "density")})

## Put the legend in the plot
print({
  group_dens3 = group_dens2 + theme(legend.position = c(.75, .75),
                legend.background = element_rect(fill="transparent"),
                legend.key = element_rect(fill="transparent", 
                                          color="transparent"))
})

## Create a dataset and put vertical lines at the means
gmeans = ddply(dat, .(grouper), summarise,  mean = mean(yij))
group_dens3 + geom_vline(data = gmeans, 
                         aes(colour = grouper, xintercept = mean))

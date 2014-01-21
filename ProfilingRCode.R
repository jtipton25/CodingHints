
# Example of Profiling R code.

# These examples are courtesy of Phil Spector.
# Consider the problem of removing rows from a data frame where any value in the
# row has an NA, i.e. there is any incomplete data.

# Here are four different functions for doing this.

# This first function, creates the output data frame one row at a time, that is 
# it adds a new row to the object res each time it finds a row that has no NAs.

funAgg = function(x) {
# initialize res 
 res = NULL
 n = nrow(x)

 for (i in 1:n) {
    if (!any(is.na(x[i,]))) res = rbind(res, x[i,])
 }
 res
}

# An alternative here is to initialise the res object to the correct size (or 
# roughly the correct size). Then replace the rows one at a time as a row in the
# input with no NAs is found. Notice that we have to keep track of where we are 
# in the output

funLoop = function(x) {
# Initialize res with x
 res = x
 n = nrow(x)
 k = 1

 for (i in 1:n) {
    if (!any(is.na(x[i,]))) {
       res[k, ] = x[i,]
       k = k + 1
    }
 }
 res[1:(k-1), ]
}

# Our next attempt, uses the property of the is.na function (i.e. that it 
# returns a matrix of logicals when given a data frame) and it employs the apply
# function. It is very simple.

funApply = function(x) {
 drop = apply(is.na(x), 1, any)
 x[!drop, ]
}
# This function is what is used in R when you call omit.na.

funOmit = function(x) {
# The or operation is very fast, it is replacing the any function
# Also note that it doesn't require having another data frame as big as x

 drop = F
 n = ncol(x)
 for (i in 1:n)
   drop = drop | is.na(x[, i])
 x[!drop, ]
}
#Make up large test case
 xx = matrix(rnorm(2000000),100000,20)
 xx[xx>2] = NA
 x = as.data.frame(xx)

# Call the R code profiler and give it an output file to hold results
  Rprof("exampleAgg.out")
# Call the function to be profiled
  y = funAgg(xx)
  Rprof(NULL)

  Rprof("exampleLoop.out")
  y = funLoop(xx)
  Rprof(NULL)
  
  Rprof("exampleApply.out")
  y = funApply(xx)
  Rprof(NULL)

  Rprof("exampleOmit.out")
  y = funOmit(xx)
  Rprof(NULL)
# The output from the profiling.

# The function funAgg - interrupted before completion 
# Each sample represents 0.02 seconds. 
# Total run time: 73.9000000000024 seconds. Total seconds: time spent in 
# function and callees. 
# Self seconds: time spent in function alone.
#
#   %       total       %       self
# total    seconds     self    seconds    name
# 100.00     73.90      0.32      0.24     "funAgg"
# 99.16     73.28     99.16     73.28     "rbind"
#  0.46      0.34      0.38      0.28     "any"
#  0.08      0.06      0.08      0.06     "is.na"
#  0.05      0.04      0.05      0.04     "!"
#
#   %       self        %       total
# self     seconds    total    seconds    name
# 99.16     73.28     99.16     73.28     "rbind"
#  0.38      0.28      0.46      0.34     "any"
#  0.32      0.24    100.00     73.90     "funAgg"
#  0.08      0.06      0.08      0.06     "is.na"
#  0.05      0.04      0.05      0.04     "!"
# The Function funLoop 
# Each sample represents 0.02 seconds. 
# Total run time: 3.56 seconds.
#
# Total seconds: time spent in function and callees. 
# Self seconds: time spent in function alone.
#
#   %       total       %       self
# total    seconds     self    seconds    name
#100.00      3.56     50.56      1.80     "funLoop"
# 46.07      1.64     39.89      1.42     "any"
#  6.18      0.22      6.18      0.22     "is.na"
#  2.25      0.08      2.25      0.08     "!"
#  1.12      0.04      1.12      0.04     "+"
#
#   %       self        %       total
# self     seconds    total    seconds    name
# 50.56      1.80    100.00      3.56     "funLoop"
# 39.89      1.42     46.07      1.64     "any"
#  6.18      0.22      6.18      0.22     "is.na"
#  2.25      0.08      2.25      0.08     "!"
#  1.12      0.04      1.12      0.04     "+"
# The function funApply 
# Each sample represents 0.02 seconds. 
# Total run time: 3.94 seconds.
#
# Total seconds: time spent in function and callees. 
# Self seconds: time spent in function alone.
#
#   %       total       %       self
# total    seconds     self    seconds    name
#100.00      3.94      2.54      0.10     "funApply"
# 97.46      3.84     46.70      1.84     "apply"
# 23.86      0.94     23.86      0.94     "FUN"
# 18.27      0.72      1.52      0.06     "unlist"
# 17.26      0.68      0.00      0.00     "any"
# 16.75      0.66     15.74      0.62     "lapply"
#  6.60      0.26      6.60      0.26     "aperm"
#  2.03      0.08      2.03      0.08     "is.na"
#  1.02      0.04      1.02      0.04     "names<-.default"
#  1.02      0.04      0.00      0.00     "names<-"
#
#   %       self        %       total
# self     seconds    total    seconds    name
# 46.70      1.84     97.46      3.84     "apply"
# 23.86      0.94     23.86      0.94     "FUN"
# 15.74      0.62     16.75      0.66     "lapply"
#  6.60      0.26      6.60      0.26     "aperm"
#  2.54      0.10    100.00      3.94     "funApply"
#  2.03      0.08      2.03      0.08     "is.na"
#  1.52      0.06     18.27      0.72     "unlist"
#  1.02      0.04      1.02      0.04     "names<-.default"
# The function funOmit 
# Each sample represents 0.02 seconds. 
#Total run time: 0.62 seconds.
#
# Total seconds: time spent in function and callees. 
# Self seconds: time spent in function alone.

   %       total       %       self
 total    seconds     self    seconds    name
100.00      0.62     38.71      0.24     "funOmit"
 48.39      0.30     48.39      0.30     "|"
 12.90      0.08     12.90      0.08     "is.na"

   %       self        %       total
 self     seconds    total    seconds    name
 48.39      0.30     48.39      0.30     "|"
 38.71      0.24    100.00      0.62     "funOmit"
 12.90      0.08     12.90      0.08     "is.na"
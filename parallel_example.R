##
## This is a basic example to introduce concepts of parallel programming in R
## using the snowfall environment. 
##

##
## Loading the Libraries
##
library(parallel) # allows the function detectCores() which allows for easy set-up on any machine
library(snowfall) # the primary parallel package <- write loops as apply commands
library(rlecuyer) # loads the random number generator needed for multi-core processing

##
## Setting up the snowfall environment
##

cps=detechCores() 
# detects the number of cores on the computer


sfInit(parallel=TRUE, cpus=cps)
# Sets up the parallel computing environment


sfExportAll()
# Exports all global variables. A global variable is a variable that can be accessed anytime in R

	
sfClusterSetupRNG() 
# Sets up the Parallel random number generator

	
sfLibrary()
# Sets up the cluster libraries if needed. For example, if the Library 'spBayes' is not exported
# to the cluster, use sfExport('spBayes')

	
##
## The biggest trick in parallel computing is to write a for loop as some form of an apply command.
## Once the loop is written as an apply (sapply, lappy, etc.) it is easy to make it parallel.
## Simply use sfApply (sfSapply, sfLapply, etc.) 
##

#Examples
# find the mean of 10000 normal mean 0 variance 1 random variables and do this for 100000 iterations...  
# Setup the simulation
n=100000 
samp=10000
silly_calculation=c()


##
## Write as a For Loop
##

start.time.loop = Sys.time()
for(i in 1:n)
{
	silly_calculation[i] = mean(rnorm(samp,0,1))
}
stop.time.loop = Sys.time()
time.taken.loop = start.time.loop - stop.time.loop 



##
## write as an apply command
##

calc.mean = funcition(i)
{
	mean(rnorm(samp,0,1))
}

start.time.sapply = Sys.time()
silly_calculation.apply = sapply(1:n,calc.mean)
stop.time.sapply = Sys.time()
time.taken.sapply = start.time.sapply - stop.time.sapply

##
## write as a snowfall apply command
##

start.time.sfSapply = Sys.time()
sfExport('calc.mean')
silly_calculation.sf = sfSapply(1:n,calc.mean)
stop.time.sfSapply = Sys.time()
time.take.sfSapply = start.time.sfSapply - stop.time.sfSapply


time.taken.loop
time.taken.sapply
time.taken.sfSapply


	## Code here - use sfApply, sfSapply, sfLapply...
	
	## ends snowfall session
	sfStop()

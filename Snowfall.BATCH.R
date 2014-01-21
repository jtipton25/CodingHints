## Example 1 - Multi-core on a single computer
sink('SnowFallExample.Rout', split=TRUE)
.Platform
.Machine
R.version
Sys.info()
 
library(snowfall) 
# 1. Initialisation of snowfall. 
# (if used with sfCluster, just call sfInit()) 
sfInit(parallel=TRUE, cpus=4)
 
# 2. Loading data. 
require(mvna) 
data(sir.adm) 
# 3. Wrapper, which can be parallelised. 
wrapper <- function(idx) { 
# Output progress in worker logfile 
cat( "Current index: ", idx, "\n" ) 
index <- sample(1:nrow(sir.adm), replace=TRUE) 
temp <- sir.adm[index, ] 
fit <- crr(temp$time, temp$status, temp$pneu) 
return(fit$coef) 
} 
# 4. Exporting needed data and loading required 
# packages on workers. 
sfExport("sir.adm") 
sfLibrary(cmprsk) 
 
# 5. Start network random number generator 
# (as "sample" is using random numbers). 
sfClusterSetupRNG() 
# 6. Distribute calculation
 
start <- Sys.time(); result <- sfLapply(1:1000, wrapper) ; Sys.time()-start
# Result is always in list form. 
mean(unlist(result)) 
# 7. Stop snowfall 
sfStop() 
 
 
 
## Example 2 - Multiple nodes on a cluster (namely, the family-guy cluster at uci-ics)
sink('SnowFallExample.Rout', split=TRUE)
.Platform
.Machine
R.version
Sys.info()
 
library(snowfall) 
# 1. Initialisation of snowfall. 
# (if used with sfCluster, just call sfInit()) 
sfInit(socketHosts=rep(c('peter-griffin.ics.uci.edu','stewie-griffin.ics.uci.edu', 'neil-goldman.ics.uci.edu', 'mort-goldman.ics.uci.edu','lois-griffin.ics.uci.edu'),each=2), cpus=10,type='SOCK',parallel=T)
 
# 2. Loading data. 
require(mvna) 
data(sir.adm) 
# 3. Wrapper, which can be parallelised. 
wrapper <- function(idx) { 
# Output progress in worker logfile 
cat( "Current index: ", idx, "\n" ) 
index <- sample(1:nrow(sir.adm), replace=TRUE) 
temp <- sir.adm[index, ] 
fit <- crr(temp$time, temp$status, temp$pneu) 
return(fit$coef) 
} 
# 4. Exporting needed data and loading required 
# packages on workers. 
sfExport("sir.adm") 
sfLibrary(cmprsk) 
 
# 5. Start network random number generator 
# (as "sample" is using random numbers). 
sfClusterSetupRNG() 
# 6. Distribute calculation
 
start <- Sys.time(); result <- sfLapply(1:1000, wrapper) ; Sys.time()-start
# Result is always in list form. 
mean(unlist(result)) 
# 7. Stop snowfall 
sfStop() 
 
 
## Example 3 - Multiple nodes on a cluster (namely, the BDUC servers of uci-ics)
## ssh to bduc, then ssh to one of their claws (the head node is 32bit whereas the other wones are 64)
## put something like
## export LD_LIBRARY_PATH=/home/vqnguyen/lib:/usr/local/lib:/usr/lib:/lib:/sge62/lib/lx24-x86 in .bashrc
## or
## Sys.setenv(LD_LIBRARY_PATH="/home/vqnguyen/lib:/usr/local/lib:/usr/lib:/lib:/sge62/lib/lx24-x86")
## in an R session.  Note: modify path to your home directory
## might have to install required packages elsewhere, like ~/Rlib, and use .libPaths() to add library path.  Put this in .Rprofile
sink('SnowFallExample.Rout', split=TRUE)
.Platform
.Machine
R.version
Sys.info()
 
# 1. Initialisation of snowfall. 
# (if used with sfCluster, just call sfInit()) 
library(snowfall)
sfInit(socketHosts=rep(c('claw1', 'claw2'),each=4), cpus=8,type='SOCK',parallel=T)
 
## Example 1 - Multi-core on a single computer
sink('SnowFallExample.Rout', split=TRUE)
.Platform
.Machine
R.version
Sys.info()
 
library(snowfall) 
# 1. Initialisation of snowfall. 
# (if used with sfCluster, just call sfInit()) 
sfInit(parallel=TRUE, cpus=2)
 
# 2. Loading data. 
require(mvna) 
data(sir.adm) 
# 3. Wrapper, which can be parallelised. 
wrapper <- function(idx) { 
# Output progress in worker logfile 
cat( "Current index: ", idx, "\n" ) 
index <- sample(1:nrow(sir.adm), replace=TRUE) 
temp <- sir.adm[index, ] 
fit <- crr(temp$time, temp$status, temp$pneu) 
return(fit$coef) 
} 
# 4. Exporting needed data and loading required 
# packages on workers. 
sfExport("sir.adm") 
sfLibrary(cmprsk) 
 
# 5. Start network random number generator 
# (as "sample" is using random numbers). 
sfClusterSetupRNG() 
# 6. Distribute calculation
 
start <- Sys.time(); result <- sfLapply(1:1000, wrapper) ; Sys.time()-start
# Result is always in list form. 
mean(unlist(result)) 
# 7. Stop snowfall 
sfStop() 
 
 
 
## Example 2 - Multiple nodes on a cluster (namely, the family-guy cluster at uci-ics)
sink('SnowFallExample.Rout', split=TRUE)
.Platform
.Machine
R.version
Sys.info()
 
library(snowfall) 
# 1. Initialisation of snowfall. 
# (if used with sfCluster, just call sfInit()) 
sfInit(socketHosts=rep(c('peter-griffin.ics.uci.edu','stewie-griffin.ics.uci.edu', 'neil-goldman.ics.uci.edu', 'mort-goldman.ics.uci.edu','lois-griffin.ics.uci.edu'),each=2), cpus=10,type='SOCK',parallel=T)
 
# 2. Loading data. 
require(mvna) 
data(sir.adm) 
# 3. Wrapper, which can be parallelised. 
wrapper <- function(idx) { 
# Output progress in worker logfile 
cat( "Current index: ", idx, "\n" ) 
index <- sample(1:nrow(sir.adm), replace=TRUE) 
temp <- sir.adm[index, ] 
fit <- crr(temp$time, temp$status, temp$pneu) 
return(fit$coef) 
} 
# 4. Exporting needed data and loading required 
# packages on workers. 
sfExport("sir.adm") 
sfLibrary(cmprsk) 
 
# 5. Start network random number generator 
# (as "sample" is using random numbers). 
sfClusterSetupRNG() 
# 6. Distribute calculation
 
start <- Sys.time(); result <- sfLapply(1:1000, wrapper) ; Sys.time()-start
# Result is always in list form. 
mean(unlist(result)) 
# 7. Stop snowfall 
sfStop() 
 
 
## Example 3 - Multiple nodes on a cluster (namely, the BDUC servers of uci-ics)
## ssh to bduc, then ssh to one of their claws (the head node is 32bit whereas the other wones are 64)
## put something like
## export LD_LIBRARY_PATH=/home/vqnguyen/lib:/usr/local/lib:/usr/lib:/lib:/sge62/lib/lx24-x86 in .bashrc
## or
## Sys.setenv(LD_LIBRARY_PATH="/home/vqnguyen/lib:/usr/local/lib:/usr/lib:/lib:/sge62/lib/lx24-x86")
## in an R session.  Note: modify path to your home directory
## might have to install required packages elsewhere, like ~/Rlib, and use .libPaths() to add library path.  Put this in .Rprofile
sink('SnowFallExample.Rout', split=TRUE)
.Platform
.Machine
R.version
Sys.info()
 
# 1. Initialisation of snowfall. 
# (if used with sfCluster, just call sfInit()) 
library(snowfall)
sfInit(socketHosts=rep(c('claw1', 'claw2'),each=4), cpus=8,type='SOCK',parallel=T)
 
# 2. Loading data. 
require(mvna) 
data(sir.adm) 
# 3. Wrapper, which can be parallelised. 
wrapper <- function(idx) { 
# Output progress in worker logfile 
cat( "Current index: ", idx, "\n" ) 
index <- sample(1:nrow(sir.adm), replace=TRUE) 
temp <- sir.adm[index, ] 
fit <- crr(temp$time, temp$status, temp$pneu) 
return(fit$coef) 
} 
# 4. Exporting needed data and loading required 
# packages on workers. 
sfExport("sir.adm") 
sfLibrary(cmprsk) 
 
# 5. Start network random number generator 
# (as "sample" is using random numbers). 
sfClusterSetupRNG() 
# 6. Distribute calculation
 
start <- Sys.time(); result <- sfLapply(1:1000, wrapper) ; Sys.time()-start
# Result is always in list form. 
mean(unlist(result)) 
# 7. Stop snowfall 
sfStop()  # 2. Loading data. 
require(mvna) 
data(sir.adm) 

# 3. Wrapper, which can be parallelised. 
wrapper <- function(idx) { 

# Output progress in worker logfile 
cat( "Current index: ", idx, "\n" ) 
index <- sample(1:nrow(sir.adm), replace=TRUE) 
temp <- sir.adm[index, ] 
fit <- crr(temp$time, temp$status, temp$pneu) 
return(fit$coef) 
} 
# 4. Exporting needed data and loading required 
# packages on workers. 
sfExport("sir.adm") 
sfLibrary(cmprsk)  

# 5. Start network random number generator 
# (as "sample" is using random numbers). 
sfClusterSetupRNG() 
# 6. Distribute calculation

start <- Sys.time(); result <- sfLapply(1:1000, wrapper) ; Sys.time()-start
# Result is always in list form. 
mean(unlist(result)) 
# 7. Stop snowfall 
sfStop()
# Installing R packages
========================================================

======
## Package rgdal

The usual install.packages(“rgdal”) won’t work.

1. Download the GDAL OS X install from kyngchaos
- http://www.kyngchaos.com/software/frameworks
- http://www.kyngchaos.com/files/software/unixport/GDAL_Complete-1.10.dmg
- Install as per usual OS X install system
- Fire up the Terminal, then emacs (or vi[m]) the .bash_login file
- Modify the PATH environment so that it reads:
export PATH=”/Library/Frameworks/GDAL.framework/Programs:$PATH”

2. Download and install proj4 from source
- http://trac.osgeo.org/proj/wiki/WikiStart#Download
- Download source code version proj-4.8.0.tar.gz (or more recent update)
- Fire up the Terminal
> cd ~/Downloads/
> tar -xzvf proj-4.8.0.tar.gz
> cd proj-4.8.0
> ./configure
> make && make test
> sudo make install
[ should install to /usr/local/lib by default]

3. Download and install rgdal from source
- http://cran.r-project.org/web/packages/rgdal/index.html <- most recent update
- Fire up the Terminal
> cd ~/Downloads/
> sudo R CMD INSTALL –configure-args=’–with-proj-include=/usr/local/lib’ rgdal_0.8-16.tar.gz


```r
library(rgdal)
```

```
## Loading required package: sp
## rgdal: version: 0.8-16, (SVN revision 498)
## Geospatial Data Abstraction Library extensions to R successfully loaded
## Loaded GDAL runtime: GDAL 1.10.1, released 2013/08/26
## Path to GDAL shared files: /Library/Frameworks/GDAL.framework/Versions/1.10/Resources/gdal
## Loaded PROJ.4 runtime: Rel. 4.8.0, 6 March 2012, [PJ_VERSION: 480]
## Path to PROJ.4 shared files: (autodetected)
```




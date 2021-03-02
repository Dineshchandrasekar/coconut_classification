setwd("E:/coconut/src")
library(raster)

indices.files = Sys.glob("../output/*.tif")[-c(1:2)]
coc.ras = raster("../output/10_coconut_class.tif")

cov = stack(indices.files)

coc.ras[!coc.ras == 1] = NA
cov.mask = mask(cov,coc.ras)
plot(cov.mask$gli)

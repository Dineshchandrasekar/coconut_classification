library(raster)

dir.in = "D:/coconut/data/s2/"
dir.out = "D:/coconut/output/"

B02 = Sys.glob(sprintf("%s*B02*",dir.in))
B03 = Sys.glob(sprintf("%s*B03*",dir.in))
B04 = Sys.glob(sprintf("%s*B04*",dir.in))
B06 = Sys.glob(sprintf("%s*B06*",dir.in))
B08 = Sys.glob(sprintf("%s*B08*",dir.in))
B12 = Sys.glob(sprintf("%s*B12*",dir.in))
B05 = Sys.glob(sprintf("%s*B05*",dir.in))
#ndvi
ndvi = function(B04,B08){
  B04 = raster(B04)
  B08 = raster(B08)
  index = (B08-B04)/(B08+B04)
  out.file = paste0(dir.out,"ndvi.tif")
  writeRaster(index,out.file)
  plot(index)
}
ndvi(B08,B04)

#leaf chlorophyll index
lci = function(B04,B05,B08){
  B04 = raster(B04)
  B05 = raster(B05)
  B08 = raster(B08)
  index = (B08-B05)/(B08+B04)
  out.file = paste0(dir.out,"lci.tif")
  writeRaster(index,out.file)
  plot(index)
}
lci(B04,B05,B08)
# Specific Leaf Area Vegetation Index
slavi = function(B04,B08,B12){
  B04 = raster(B04)
  B08 = raster(B08)
  B12 = raster(B12)
  index = B08 / (B04 + B12)
  out.file = paste0(dir.out,"slavi.tif")
  writeRaster(index,out.file)
  plot(index)
}
slavi(B04,B08,B12)
#Transformed Chlorophyll Absorbtion Ratio
tcari = function(B03,B04,B05){
  B03 = raster(B03)
  B04 = raster(B04)
  B05 = raster(B05)
  index = 3.0 * ((B05 - B04) - 0.2 * (B05 - B03) * (B05 / B04))
  out.file = paste0(dir.out,"tcari.tif")
  writeRaster(index,out.file)
  plot(index)
}
tcari(B03,B04,B05)

#Green leaf index
gli = function(B02,B03,B04){
  B02 = raster(B02)
  B03 = raster(B03)
  B04 = raster(B04)
  index = (2.0 * B03 - B04 - B02) / (2.0 * B03 + B04 + B02)
  out.file = paste0(dir.out,"gli.tif")
  writeRaster(index,out.file)
  plot(index)
}
gli(B02,B03,B04)


library(raster)
in.files = Sys.glob("C:/Users/Dineshkumar/Downloads/data/data/*20m*")
base.ras = raster(Sys.glob("C:/Users/Dineshkumar/Downloads/data/data/*B08*10m*"))

for (ii in in.files) {
  in.ras = raster(ii)
  b.name = names(in.ras)
  b.name = gsub("_20m","_10m",b.name)
  out.file = paste0("D:/coconut/data/s2/",b.name,".tif")
  if(!file.exists(out.file)){
    res.ras = resample(in.ras,base.ras, method="bilinear")
    writeRaster(res.ras,out.file)
  }
}

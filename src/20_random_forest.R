setwd("E:/coconut/src")

library(rgdal)
library(raster)
library(randomForest)
library(caret)
library(e1071)

out.dir = "../output/"
s2.files = Sys.glob("../data/s2/*.tif")
indices.files = Sys.glob("../output/*.tif")[-c(1:2)]
in.shp = readOGR("../data/gpkg/gt_pts.gpkg")

bands = stack(s2.files)
cov = stack(indices.files)

var = stack(bands,cov)

test.xy <- extract(var, in.shp,sp= TRUE,method = "simple")
test.xy$land_type = as.factor(test.xy$land_type)
data.df<- as.data.frame(test.xy)
data.df = data.df[c(1:20)]
# training <- sample(nrow(data.df), 0.8 * nrow(data.df))
# train.df  <-  data.df[training, ]
# test.df  <-  data.df[-training, ]

set.seed(543)

rf.model = randomForest(land_type ~.  ,data = data.df,importance=TRUE)

#calibration
# cali.Pred <- rf.model$predicted
# #Confusion matrix
# cali.confu <- caret::confusionMatrix(cali.Pred, train.df$land_type)
# print(cali.confu$overall[1])

#validation
# #Confusion matrix
# vali.Pred <- predict(rf.model, test.df)
# vali.confu <- caret::confusionMatrix(vali.Pred,test.df$land_type)
# print(vali.confu$overall[1])
# 
# #raster creation
crop.class <- predict(var, rf.model)
writeRaster(crop.class, file.path(out.dir,"10_coconut_class"),format = "GTiff")


#area in hectares
r.class = crop.class[]
length(r.class[r.class == 1]) * 10 * 10 * 0.0001

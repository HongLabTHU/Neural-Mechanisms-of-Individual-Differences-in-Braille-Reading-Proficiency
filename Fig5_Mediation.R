#! /usr/bin/env Rscript
# TD_modu via area of funLOC predicts Proficiency
library(readxl)
data_mediation <- read_excel("../Data/Fig5_DataforMediation.xlsx", 
                             sheet = "topdown_profi")
mydata <- as.data.frame(data_mediation)
View(mydata)

library(mediation)
mediate <- mediation::mediate

# USE! 
mod.xm = lm(MLOCarea ~ XTD, mydata)
print(summary(mod.xm))
mod.xy = lm(Yproficiency ~ XTD + MLOCarea, mydata)
set.seed(1234)
mod.medXTD <- mediate(mod.xm, mod.xy, treat = "XTD", mediator = "MLOCarea", sims = 5000, boot = T, boot.ci.type = "bca")
summary(mod.medXTD)
plot(mod.medXTD)


#Data cleaning on REIT
FFR = read.csv("/Users/damodarbihani/Desktop/Capstone\ Data/Real\ Estate/FFR.csv")

FFR_return = NULL
for(i in 2:nrow(FFR))
{
  FFR_return[i] = (FFR$Adj.Close[i] - FFR$Adj.Close[i-1])/FFR$Adj.Close[i-1] #calculate Returns
}
FFR$FFR_Ret = FFR_return

#Export
write.csv(FFR[,c(1,8)],"/Users/damodarbihani/Desktop/Capstone\ Data/Real\ Estate/FFR_Ret.csv")
data_ffr = FFR[,c(1,8)]
#save(data_ffr,"data_ffr",file = "/Users/damodarbihani/Desktop/Capstone\ Data/Data_cleaned_all/ffr.rda")
#load("/Users/damodarbihani/Desktop/Capstone\ Data/Data_cleaned_all/ffr.rda")

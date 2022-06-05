#Correlation Matrix Analysis on Portfolio of Aug. 2021

#install.packages("corrplot")
library(corrplot)
dat_2021_8 = list_all[["2021 8"]]$weights[list_all[["2021 8"]]$weights > 0.00] #Look at the assets that picked by the Optimized Portfolio
list_2021_8 = names(dat_2021_8)
cor_analysis = NULL
for( i in 1:length(dat_2021_8))
{
  if(!(names(dat_2021_8[i]) %in% stock_list)) #For all assets that are not stock, we compared them to SP500
  {
    cor_analysis = cbind(cor_analysis,datalist[["2021 8"]][,names(dat_2021_8[i])])
    colnames(cor_analysis)[ncol(cor_analysis)] = names(dat_2021_8[i])
  }
}
cor_analysis = data.frame("SP500" = datalist[["2021 8"]]$sp_ret, cor_analysis)
cor_analysis = cor(as.matrix(cor_analysis))

corrplot(cor_analysis, type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)

corrplot(cor_analysis, type = "upper", order = "original", tl.col = "black", tl.srt = 45) #Plot the Correlation Matrix

corrplot.mixed(cor_analysis)

#Export
datfr_2021_8 = data.frame(dat_2021_8)
write.csv(datfr_2021_8, "/Users/andyqiwei/Desktop/Capstone\ Data/2021_8\ weight/datfr_2021_8.csv")

# Using IntroCompFinR package for portfolio construction
library(tseries)
library(IntroCompFinR)

#create a function to deal with NA in a simple way
drop_Nas <- function (data,dim){
      if (dim == 2){
        na_flag <- apply(!is.na(data),2,sum) # use ! to inverse 1 (to 0 0) and 0 (to 1).
        data <- data[,-which(na_flag == 0)]
        }
     else if (dim == 1){
      na_flag <- apply(!is.na(data),1,sum)
      data <- data[-which(na_flag == 0),]
      }
     else{
       warning("dim can only equal to 1 and 2, 1 means row, 2 means column ")
       }
   return(data)
} # 1 for dropping rows, 2 for dropping columns

#Try to build some portfolio based on different time frame
#2010-2018 Traditional
index = (all_data$date >= "2010-01-01" & all_data$date <= "2018-12-31")
usefuldata = na.omit(drop_Nas(all_data[index,2:505],2))
vcv = cov(usefuldata)
mean_all = apply(usefuldata,2,mean)
tangency.portfolio(mean_all,vcv,risk.free = 0.00,shorts = FALSE)


#2010-2018 Alternative
index = (all_data$date >= "2010-01-01" & all_data$date <= "2018-12-31")
usefuldata = na.omit(drop_Nas(all_data[index,-1:-506],2))
vcv = cov(usefuldata)
mean_all = apply(usefuldata,2,mean)
tangency.portfolio(mean_all,vcv,risk.free = 0.00,shorts = FALSE)


#2018-2020 Alternative
index = (all_data$date >= "2019-01-01" & all_data$date <= "2020-12-31")
usefuldata = na.omit(drop_Nas(all_data[index,-1:-506],2))
vcv = cov(usefuldata)
mean_all = apply(usefuldata,2,mean)
tangency.portfolio(mean_all,vcv,risk.free = 0.00,shorts = FALSE)

#all
usefuldata = na.omit(all_data[,-1:-506])
vcv = cov(usefuldata)
mean_all = apply(usefuldata,2,mean)
tangency.portfolio(mean_all,vcv,risk.free = 0.00,shorts = FALSE)





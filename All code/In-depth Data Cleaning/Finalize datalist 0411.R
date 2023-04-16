
#Separate the dataset according to year and month to have different time window for analysis

library(lubridate)
load("/Users/damodarbihani/Desktop/Capstone\ Data/Data_cleaned_all/all_data_new.rda")
all_data_new = all_data_new[c(-1,-2,-3090),] #exclude useless rows

all_data_new$year_month = paste(year(all_data_new$date),month(all_data_new$date)) #create a column of year_month

year_month_list = unique(all_data_new$year_month) #find all time window tags

year_month_list = year_month_list
set.seed(1234) 
datalist = list()
k = 1

f<-function(x) sum((is.na(x)))

for( window in year_month_list)
{
  station = all_data_new[all_data_new$year_month == window,]
  station = station[,!names(station) %in% c("date","year_month")]
  for(m in 1:nrow(station))
  {
    for(n in 1:ncol(station))
    {
      if(is.infinite(station[m,n]))
      {
        station[m,n] = NA #set all Inf to NA in our dataset (The unknown value)
      }
    }
  }
  cal_na = apply(station,2,f) #calculate how many NAs in each column
  mean_station = apply(station, 2, function(x) mean(x,na.rm = TRUE))
  sd_station = apply(station, 2, function(x) sd(x,na.rm = TRUE))
  delete_col = NULL
  for(i in 1 : length(cal_na))
  {
    if(cal_na[i] >= 0.75 * nrow(station)) 
    {
      delete_col = c(delete_col, i) #If there are more than 75% NAs in that asset, delete the asset in that time window
    }
    else if((cal_na[i] < 0.75 * nrow(station)) & cal_na[i] != 0)
    {
      for(p in 1: nrow(station))
      {
        if(is.na(station[p,i]))
        {
          station[p,i] = rnorm(1,mean = mean_station[i], sd = sd_station[i]) # #If there are less than 75% NAs in that asset, simulate the returns for that NAs by normal distribution
        }
      }
    }
  }
  if (is.null(delete_col)) {}
  else { station = station[,-delete_col]} #delete the columns that contain >75% NAs
  rownames(station) = all_data_new[all_data_new$year_month == window,]$date
  datalist[[k]] = station
  k = k + 1
}
names(datalist) = year_month_list #rename

#Export
save(datalist,"datalist",file = "/Users/damodarbihani/Desktop/Capstone\ Data/Finalize\ datalist\ 0411/finaldatalist.rda")

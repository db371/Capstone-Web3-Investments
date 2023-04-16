#Data Cleaning on vanguard ETF

vanguard = read.csv("/Users/damodarbihani/Desktop/Capstone\ Data/vanguard/New\ Vanguard\ Total\ Bond\ ETF.csv")
vanguard$Date = as.Date(vanguard$Date, format = "%m/%d/%y") #convert to date
vanguard = vanguard[order(vanguard$Date),]
vanguard = vanguard[,c(1,5)]
ret_bond = NULL
for (i in 2:nrow(vanguard)) {
  ret_bond[i] = (vanguard$Close[i] - vanguard$Close[i-1])/vanguard$Close[i] #calculate return
}
data_vanguard = data.frame("date" = vanguard$Date, ret_bond) 

#Export
save(data_vanguard,"data_vanguard", file = "/Users/damodarbihani/Desktop/Capstone\ Data/Data_cleaned_all/data_vanguard.rda")





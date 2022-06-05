#Data cleaning for Treasury bonds

#Read treasury bonds simultaneously
path <- "/Users/andyqiwei/Desktop/Capstone\ Data/treasury\ bonds"
fileNames <- dir(path) 
filePath <- sapply(fileNames, function(x){ 
  paste(path,x,sep='/')})   
data_bond <- lapply(filePath, function(x){
  read.csv(x)}) 

bond_all = NULL
for (i in c(2,3,4,5,12))
{
  data_bond[[i]] = data_bond[[i]][,-3] #extract useful columns
}
for (i in 1:length(data_bond))
{
  data_bond[[i]]$Date = as.Date(data_bond[[i]]$Date,format = "%m/%d/%Y") #convert to date
  bond_all = rbind(bond_all,data_bond[[i]])
}

#Export
save(bond_all,"data_bond",file = "/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/data_bond.rda")
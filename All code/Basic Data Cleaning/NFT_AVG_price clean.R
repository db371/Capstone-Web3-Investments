#Data cleaning on NFT AVG Price data

#Read files simultaneously in the same folder
path <- "/Users/andyqiwei/Desktop/Capstone\ Data/NFTs"
fileNames <- dir(path) 
filePath <- sapply(fileNames, function(x){ 
  paste(path,x,sep='/')})   
data_nft <- lapply(filePath, function(x){
  read.csv(x)}) 

ETH.price = read.csv("/Users/andyqiwei/Desktop/Capstone\ Data/Cryptos_new/eth.csv") #Read ETH price
ETH.price = ETH.price[,c(2,5)]
ETH.price$date = substr(ETH.price$timestamp, 1,10) #extract date info
ETH.price$date = as.Date(ETH.price$date) #convert to Date class
ETH.price = ETH.price[,c(3,2)] 

#Since NFT price is based on ETH, we need to convert it to USD
for(i in 1:length(filePath))
{
  data_nft[[i]]$Date =  as.Date(data_nft[[i]]$Date, format = "%m/%d/%y")
  data_nft[[i]]$date = data_nft[[i]]$Date
  data_nft[[i]] = merge(data_nft[[i]],ETH.price,by = "date",all.x = TRUE) #Merge NFT and ETH Togther
  data_nft[[i]]$Price_ETH_all = data_nft[[i]]$Price_ETH * data_nft[[i]]$price #Get the USD Price for NFT
  stage = NULL
  for( j in 2: nrow(data_nft[[i]]))
  {
    stage[j] = (data_nft[[i]]$Price_ETH_all[j] - data_nft[[i]]$Price_ETH_all[j-1])/data_nft[[i]]$Price_ETH_all[j-1] #Calculate returns
  }
  data_nft[[i]]$return = stage
  station = data.frame("date" = as.Date(data_nft[[i]]$Date), "return" = stage)
  colnames(station)[2] = paste0(gsub('.{4}$',"",fileNames[i]),"_return") #Rename
  data_nft[[i]] = station
}

#Export
save(data_nft,"data_nft",file = "/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/nft.rda")
#load("/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/nft.rda")

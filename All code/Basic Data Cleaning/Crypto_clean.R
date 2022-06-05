# Crypto Data Cleaning

#Read all crypto data simultaneously
path <- "/Users/andyqiwei/Desktop/Capstone\ Data/Cryptos_new"
fileNames <- dir(path) 
filePath <- sapply(fileNames, function(x){ 
  paste(path,x,sep='/')})   
data_crypto <- lapply(filePath, function(x){
  read.csv(x)}) 


for(i in 1:length(filePath))
{
  data_crypto[[i]]$date = substr(data_crypto[[i]]$timestamp, 1,10) #extract the data info
  data_crypto[[i]]$date = as.Date(data_crypto[[i]]$date) #convert to data format
  data_crypto[[i]] = data_crypto[[i]][,c(8,5)]
  stage = NULL
  for( j in 2: nrow(data_crypto[[i]]))
  {
    stage[j] = (data_crypto[[i]]$price[j] - data_crypto[[i]]$price[j-1])/data_crypto[[i]]$price[j-1] #calculate return
  }
  data_crypto[[i]]$return = stage
  colnames(data_crypto[[i]])[2] = paste0(gsub('.{4}$',"",fileNames[i]),"_price") #give colname name
  colnames(data_crypto[[i]])[3] = paste0(gsub('.{4}$',"",fileNames[i]),"_return") #give colname name
}

#Export
#save(data_crypto,"data_crypto",file = "/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/crypto.rda")
#load("/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/crypto.rda")

#Merge all return datasets together to get a comprehensive dataset for analysis

load("/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/data_bond.rda")
load("/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/data_stock.rda")
load("/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/ffr.rda")
load("/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/nft_token.rda")
load("/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/nft.rda")
load("/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/crypto.rda")
load("/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/sp500.rda")
load("/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/data_vanguard.rda")

all_data = data_stock
colnames(data_nft_token)[1] = "date"
all_data = merge(all_data,data_nft_token,by = "date",all.x = TRUE) #merge nft token

for( i in 1:length(data_nft))
{
  all_data = merge(all_data,data_nft[[i]],by = "date",all.x = TRUE) #merge nft
}

for(i in 1:length(data_crypto))
{
  station = data_crypto[[i]][,c(1,3)]
  all_data = merge(all_data,station,by = "date",all.x = TRUE) #merge crypto
}

all_data = merge(all_data,data_sp,by = "date",all.x = TRUE) #merge SP500

all_data = merge(all_data,data_vanguard,by = "date",all.x = TRUE) #merge vanguard

all_data_new = all_data

#Export
save(all_data_new,"all_data_new", file = "/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/all_data_new.rda")



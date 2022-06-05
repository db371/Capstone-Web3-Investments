library(data.table)
#This file is for data cleaning on NFT Tokens data, the output is an csv file and an rda file

#NFT Tokens input
axs = read.csv("/Users/andyqiwei/Desktop/Capstone\ Data/NFT\ Tokens/axs-usd-max.csv")
axs = data.frame("Date" = axs[,1],"Price_axs" = axs[,2])
axs[,1] = as.Date(substring(axs[,1],1,10))

mana = read.csv("/Users/andyqiwei/Desktop/Capstone\ Data/NFT\ Tokens/mana-usd-max.csv")
mana = data.frame("Date" = mana[,1],"Price_mana" = mana[,2])
mana[,1] = as.Date(substring(mana[,1],1,10))

sand = read.csv("/Users/andyqiwei/Desktop/Capstone\ Data/NFT\ Tokens/sand-usd-max.csv")
sand = data.frame("Date" = sand[,1],"Price_sand" = sand[,2])
sand[,1] = as.Date(substring(sand[,1],1,10))

theta = read.csv("/Users/andyqiwei/Desktop/Capstone\ Data/NFT\ Tokens/theta-usd-max.csv")
theta = data.frame("Date" = theta[,1],"Price_theta" = theta[,2])
theta[,1] = as.Date(substring(theta[,1],1,10))

#mana has the largest duration
#merge all NFT Tokens together
Token_all = merge(mana, theta,by = "Date", all.x = TRUE)
Token_all = merge(Token_all, sand,by = "Date", all.x = TRUE)
Token_all = merge(Token_all, axs,by = "Date", all.x = TRUE)

#Calculate returns
Token_all = data.table(Token_all)
Token_all[, Pdiff_axs := c(NA,diff(Price_axs))]
Token_all[, ret_axs := (Pdiff_axs)/shift(Price_axs,n=1,type='lag',fill=NA)]

Token_all[, Pdiff_mana := c(NA,diff(Price_mana))]
Token_all[, ret_mana := (Pdiff_mana)/shift(Price_mana,n=1,type='lag',fill=NA)]

Token_all[, Pdiff_sand := c(NA,diff(Price_sand))]
Token_all[, ret_sand := (Pdiff_sand)/shift(Price_sand,n=1,type='lag',fill=NA)]

Token_all[, Pdiff_theta := c(NA,diff(Price_theta))]
Token_all[, ret_theta := (Pdiff_theta)/shift(Price_theta,n=1,type='lag',fill=NA)]

Token_all = Token_all[,c(1:5,7,9,11,13)]

#Research on correlation
cor(Token_all[,6:9],use = "na.or.complete") #4 kinds of tokens all correlated
data_nft_token = Token_all[,c(1,6:9)]

#Output and Export
#write.csv(Token_all[,c(1,6:9)],"/Users/andyqiwei/Desktop/Capstone\ Data/Token_return.csv")
save(data_nft_token,"data_nft_token",file = "/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/nft_token.rda")

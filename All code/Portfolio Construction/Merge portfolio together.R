#Merge the portfolios constructed on different computers together

load("/Users/damodarbihani/Desktop/Capstone\ Data/Datalist\ gathering/weight_list_db1_71_85.rda")
load("/Users/damodarbihani/Desktop/Capstone\ Data/Datalist\ gathering/weight_list_db2_86_105.rda")
load("/Users/damodarbihani/Desktop/Capstone\ Data/Datalist\ gathering/weight_list_kg1_106_126.rda") 
load("/Users/damodarbihani/Desktop/Capstone\ Data/Datalist\ gathering/weight_list_kg2_127_147.rda")
load("/Users/damodarbihani/Desktop/Capstone\ Data/Datalist\ gathering/weight_list_mp1_36_53.rda") 
load("/Users/damodarbihani/Desktop/Capstone\ Data/Datalist\ gathering/weight_list_mp2_54_70.rda") 
load("/Users/damodarbihani/Desktop/Capstone\ Data/Datalist\ gathering/weight_list_ql1_01_17.rda") 
load("/Users/damodarbihani/Desktop/Capstone\ Data/Datalist\ gathering/weight_list_ql2_18_35.rda")
load("/Users/damodarbihani/Desktop/Capstone\ Data/Datalist\ gathering/weight_list_ql2_18_29.rda")
load("/Users/damodarbihani/Desktop/Capstone\ Data/Datalist\ gathering/weight_list_ql2_30_35.rda")
load("/Users/damodarbihani/Desktop/Capstone\ Data/Datalist\ gathering/weight_list_na_inf.rda")

load("/Users/damodarbihani/Desktop/Capstone\ Data/Data_cleaned_all/data_stock.rda")
load("/Users/damodarbihani/Desktop/Capstone\ Data/Data_cleaned_all/ffr.rda")
load("/Users/damodarbihani/Desktop/Capstone\ Data/Data_cleaned_all/nft_token.rda")
load("/Users/damodarbihani/Desktop/Capstone\ Data/Data_cleaned_all/nft.rda")
load("/Users/damodarbihani/Desktop/Capstone\ Data/Data_cleaned_all/crypto.rda")
load("/Users/damodarbihani/Desktop/Capstone\ Data/Data_cleaned_all/sp500.rda")
load("/Users/damodarbihani/Desktop/Capstone\ Data/Data_cleaned_all/data_vanguard.rda")


list_all = list()
for (i in 1:17) {
  list_all[[i]] = weight_list_ql1_01_17[[i]]
}

for (i in 18:29) {
  list_all[[i]] = weight_list_ql2_18_29[[i]]
}

for (i in 30:35) {
  list_all[[i]] = weight_list_ql2_30_35[[i]]
}

for (i in 36:53) {
  list_all[[i]] = weight_list_mp1_36_53[[i]]
}

for (i in 54:70) {
  list_all[[i]] = weight_list_mp2_54_70[[i]]
}

for (i in 71:85) {
  list_all[[i]] = weight_list_db1_71_85[[i]]
}

for (i in 86:105) {
  list_all[[i]] = weight_list_db2_86_105[[i]]
}

for (i in 106:126) {
  list_all[[i]] = weight_list_kg1_106_126[[i]]
}

for (i in 127:147) {
  list_all[[i]] = weight_list_kg2_127_147[[i]]
}

inf_na_list = c(92:95,97:104,106,108,109,111,113,114,115,117)
for( p in inf_na_list)
{
  list_all[[p]] = weight_list_na_inf[[p]]
}

names(list_all) = names(datalist) #rename

#Give assets class to different assets
#Calculate asset class weights besides individual asset weight
stock_list = colnames(data_stock)[-1]
ffr_list = "FFR_Ret"
nft_list = c("Autoglyphs_return","BAYC_return","Chromiesquiggle_return","Clonex_return",
                    "Coolcats_return","Cryptopunks_return","Cyberkongz_return","MAYC_return",
                    "Meebits_return","Veefriends_return")
nft_token_list = colnames(data_nft_token)[-1]
crypto_list = c("bat_return","btc_return","dai_return","eos_return","etc_return","eth_return",
                    "etp_return","ltc_return","monero_return","neo_return","omg_return","rep_return",
                    "stellar_return","tron_return","verge_return" )
sp500_list = "sp_ret"
bond_list = "ret_bond"

type_weight = NULL
for( i in 1: length(list_all))
{
  stock_w = sum(list_all[[i]]$weights[names(list_all[[i]]$weights) %in% stock_list])
  bond_w = sum(list_all[[i]]$weights[names(list_all[[i]]$weights) %in% bond_list])
  ffr_w = sum(list_all[[i]]$weights[names(list_all[[i]]$weights) %in% ffr_list])
  sp500_w = sum(list_all[[i]]$weights[names(list_all[[i]]$weights) %in% sp500_list])
  nft_token_w = sum(list_all[[i]]$weights[names(list_all[[i]]$weights) %in% nft_token_list])
  nft_w = sum(list_all[[i]]$weights[names(list_all[[i]]$weights) %in% nft_list])
  crypto_w = sum(list_all[[i]]$weights[names(list_all[[i]]$weights) %in% crypto_list])
  station = c(stock_w,bond_w,ffr_w,sp500_w,nft_token_w,nft_w,crypto_w)
  type_weight = rbind(type_weight,station) #Calculate the type weight (Sum weights in specific assets up)
}
rownames(type_weight) = names(datalist)
colnames(type_weight) = c("stock_w","bond_w","ffr_w","sp500_w","nft_token_w","nft_w","crypto_w")


#Calculate MVE Portfolio Sharpe Ratio and SP500 Sharpe Ratio
SharpeRatio_port = NULL
for (i in 1:length(list_all))
{
SharpeR_p = unlist(list_all[[i]]$opt_values[1])/list_all[[i]]$opt_values$StdDev[1,] #Calculate SharpeRation with rf = 0
SharpeR_sp500 = mean(datalist[[i]]$sp_ret)/sd(datalist[[i]]$sp_ret)
station_Sharpe = c(SharpeR_p,SharpeR_sp500)
SharpeRatio_port = rbind(SharpeRatio_port,station_Sharpe)
}
rownames(SharpeRatio_port) = names(datalist)
colnames(SharpeRatio_port) = c("SharpeR_p","SharpeR_sp500")

#Trading strategy
#previous month for trading strategy
#We use last month weight for current weight and look at the sharpe ratio
SharpeRatio_sim = NULL
for(i in 1: (length(list_all)-1))
{
  weight_now = list_all[[i]]$weights
  weight_now = data.frame( "weight" = weight_now)
  weight_now = data.frame("asset"= rownames(weight_now),"weight" = weight_now)
  data_next = t(datalist[[i+1]])
  data_next = data.frame("asset"= rownames(data_next),data_next)
  combine_for_next = merge(data_next,weight_now,by = "asset",all.x = TRUE)
  return_sim = NULL
  for(j in 2:(ncol(combine_for_next) - 1))
  {
    return_sim[j - 1] = sum(na.omit(combine_for_next[,j]*combine_for_next[,ncol(combine_for_next)])) #Calculate new returns
  }
  SharpeR_sim = mean(return_sim)/sd(return_sim)
  SharpeR_sp500_next = mean(datalist[[i+1]]$sp_ret)/sd(datalist[[i+1]]$sp_ret)
  station_sim = c(SharpeR_sim,SharpeR_sp500_next)
  SharpeRatio_sim = rbind(SharpeRatio_sim,station_sim)
}

rownames(SharpeRatio_sim) = names(datalist)[2:147]
colnames(SharpeRatio_sim) = c("SharpeR_sim","SharpeR_sp500")

plot(SharpeRatio_port, xlim=c(-0.5,1.2),ylim=c(-0.5,1.2)) #Basic visualization on Sharpe Ratio
abline(a=0,b=1)
sum(SharpeRatio_port[,1]>SharpeRatio_port[,2])/nrow(SharpeRatio_port)


plot(SharpeRatio_sim, xlim=c(-0.5,1.2),ylim=c(-0.5,1.2))
abline(a=0,b=1)

sum(SharpeRatio_sim[,1]>SharpeRatio_sim[,2])/nrow(SharpeRatio_sim)

write.csv(SharpeRatio_port,"/Users/andyqiwei/Desktop/Capstone\ Data/Outcome/SharpeRatio_port.csv")
write.csv(SharpeRatio_sim,"/Users/andyqiwei/Desktop/Capstone\ Data/Outcome/SharpeRatio_sim.csv")
write.csv(type_weight,"/Users/andyqiwei/Desktop/Capstone\ Data/Outcome/type_weight.csv")

#Print out returns comparision
return_port = NULL
return_sp = NULL
for( i in 1: length(list_all))
{
  return_port = c(return_port,unlist(list_all[[i]]$opt_values)[1])
  return_sp = c(return_sp, mean(datalist[[i]]$sp_ret,na.rm = TRUE))
}

return_compare = data.frame(return_port,return_sp)
rownames(return_compare) = names(datalist)
write.csv(return_compare,"/Users/andyqiwei/Desktop/Capstone\ Data/Outcome/return_compare.csv")


#Print out volatility comparision
volatily_port = NULL
volatily_sp = NULL
for( i in 1: length(list_all))
{
  volatily_port = c(volatily_port,unlist(list_all[[i]]$opt_values)[2])
  volatily_sp = c(volatily_sp, sd(datalist[[i]]$sp_ret,na.rm = TRUE))
}

volatily_compare = data.frame(volatily_port,volatily_sp)
rownames(volatily_compare) = names(datalist)
write.csv(volatily_compare,"/Users/damodarbihani/Desktop/Capstone\ Data/Outcome/volatily_compare.csv")




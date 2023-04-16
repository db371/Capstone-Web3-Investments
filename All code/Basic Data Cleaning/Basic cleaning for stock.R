#Data cleaning on Stock
stock_all = read.csv("/Users/damodarbihani/Desktop/Capstone\ Data/Stock/sp500_stocks.csv")

N_stock = length(unique(stock_all$Symbol))
stock_list = unique(stock_all$Symbol)
stock_cleaned = NULL
for(i in stock_list)
{
  stock_cleaned = cbind(stock_all[stock_all$Symbol == i, 3], stock_cleaned) #convert panel data to a formatted dataframe
}

colnames(stock_cleaned) = paste(stock_list,"Adj.Close")
stock_return = matrix(NA,nrow(stock_cleaned),ncol(stock_cleaned))
q = 0
for(p in 2: nrow(stock_cleaned))
{
  for(q in 1: ncol(stock_cleaned))
  {
  if(is.na(stock_cleaned[p - 1,q]))
  {
    stock_return[p,q] = NA
  }
  else 
    {
    stock_return[p,q] = (stock_cleaned[p,q] - stock_cleaned[p-1,q])/stock_cleaned[p-1,q] #calculate stock return
      }
  }
}
colnames(stock_return) = paste(stock_list,"Return")
data_stock = data.frame("date" = as.Date(stock_all[stock_all$Symbol == "AAPL", 1]),stock_return) #make the final data frame

#Export
#write.csv(stock_return,"/Users/damodarbihani/Desktop/Capstone\ Data/Stock/Finish/stock_return.csv")
#write.csv(stock_cleaned,"/Users/damodarbihani/Desktop/Capstone\ Data/Stock/Finish/stock_adj.closed.csv")
save(data_stock, "data_stock", file = "/Users/damodarbihani/Desktop/Capstone\ Data/Data_cleaned_all/data_stock.rda")





#Data cleaning on SP500 Index
library(quantmod) 

#Getting data from yahoo finance
sp500 <- getSymbols("^GSPC",src="yahoo",
                    from="2010-01-04",
                    to="2022-04-01",
                    auto.assign=FALSE)
sp500 = data.frame("date" = time(sp500), sp500$GSPC.Adjusted)
rownames(sp500) = 1:nrow(sp500)
sp_ret = NULL
for(i in 2: nrow(sp500))
{
  sp_ret[i] = (sp500$GSPC.Adjusted[i] - sp500$GSPC.Adjusted[i-1])/sp500$GSPC.Adjusted[i-1] #calculate returns
}
data_sp = data.frame("date" = sp500$date,sp_ret)

#Export
save(data_sp,"data_sp", file = "/Users/andyqiwei/Desktop/Capstone\ Data/Data_cleaned_all/sp500.rda")

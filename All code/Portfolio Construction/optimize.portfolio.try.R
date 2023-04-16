#Use R-package "PortfolioAnalytics" for Portfolio Construction

library(foreach)
library(ROI)
library(ROI.plugin.quadprog)
library(ROI.plugin.glpk)
library(PortfolioAnalytics)

load("/Users/damodarbihani/Desktop/Capstone\ Data/Finalize\ datalist\ 0411/finaldatalist.rda")
weight_list = list() #Store the outcome

#Because it takes too long to run 147 portfolio in one computer, we use 8 Fuqua's computers to run the code
#Split the task to different computers based on Initial
QL_1 = 1:17
QL_2 = 18:35
MP_1 = 36:53
MP_2 = 54:70
DB_1 = 71:85
DB_2_new = 86:96
DB_3_new = 97:105
KG_1 = 106:126
KG_2 = 127:147

inf_na_list = c(93:95,97:104,106,108,109,111,113,114,115,117)
YourInitial = QL_1
for (i in YourInitial)
{
# Create portfolio object
portf_maxret <- portfolio.spec(assets=colnames(datalist[[i]]))
# Add constraints to the portfolio object
#portf_maxret <- add.constraint(portfolio=portf_maxret, type="weight_sum", min_sum=1, max_sum=1) 
#portf_maxret <- add.constraint(portfolio=portf_maxret, type= "box",min=0, max=1)
portf_maxret <- add.constraint(portfolio=portf_maxret, type="full_investment") #add constraint of 100% Investment
portf_maxret <- add.constraint(portfolio=portf_maxret, type="long_only") #add constraint of positive weight
# Add objective to the portfolio object
portf_maxret <- add.objective(portfolio=portf_maxret, type = "return", name = "mean")
portf_maxret <- add.objective(portfolio=portf_maxret, type= "risk", name="StdDev")
port_station = optimize.portfolio(R=datalist[[i]], portfolio=portf_maxret, optimize_method="random",search_size = 10000, maxSR=TRUE,trace=TRUE) #use "random" as optimizer, 10000 as the search_size for a stable result, trace = TRUE
weight_list[[i]] = port_station
}

#Export
#weight_list_ql2_30_35 = weight_list
#save(weight_list_ql2_30_35, "weight_list_ql2_30_35", file = "/Users/damodarbihani/Desktop/Capstone\ Data/Datalist\ gathering/weight_list_ql2_30_35.rda")

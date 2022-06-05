**The code files presented are for the Capstone Project undertaken at Duke University, Fuqua School of Business.**

Team: Damodar Bihani, Kevin Garcia, Qiwei Liu, Mrunmayee Padhye

**Read Me**

**Basic Data Cleaning**

•	NFT Tokens Basic cleaning. R: Data cleaning on NFT Tokens data, the output is a .csv file and a .rda file with date and return information

•	Crypto_clean. R: Data Cleaning on Crypto data, the output is a .rda file with date and return information

•	Basic cleaning for stock. R: Data Cleaning on S&P 500 individual stocks, the output is a .rda file with date and return information

•	Clean Estate. R: Data Cleaning on REIT (FFR), the output is a .csv file and a .rda file with date and return information

•	Clean_TBill.R: Data Cleaning on TBill, the output is a .rda file with date and return information

•	Clean SP500.R: Data Cleaning on SP500 Index, the output is a .rda file with date and return information

•	Clean vanguard.R: Data Cleaning on Vanguard Bond ETF Index, the output is a .rda file with date and return information

•	NFT_AVG_price clean.R: Data cleaning on NFT AVG Price data and the outputs is a .rda file with date and return information

**In-depth Data cleaning**

•	Merge all_Final. R: Merge all return datasets together to get a comprehensive dataset for analysis. The output is a .rda file including all assets returns and date

•	Finalize datalist 0411.R: Separate the dataset according to year and month to have different time window for analysis. The output is a list in .rda file with cleaned data in each time window

**Portfolio Construction**

•	Try to run a MVE.R: Used R-package “IntroCompFinR” for portfolio construction with tangency.portfolio. Tried 4 time frames of portfolio construction and found this package cannot satisfy our demand.

•	Optimize.portfolio.try.R: Use R-package "PortfolioAnalytics" for Portfolio Construction. The outputs are many .rda files with the info of optimized portfolio in different time window based on the results of different computers.

•	Merge portfolio together.R:
1.	Merge the portfolios constructed on different computers together
2.	Calculate asset class weights besides individual asset weight
3.	Calculate MVE Portfolio Sharpe Ratio and SP500 Sharpe Ratio
4.	Trading strategy analysis: used last month weight for current weight and look at the sharpe ratio
5.	Visualization on SR comparison, Return comparison and Volatility comparison

•	Outcome Analysis:
1.	Finding returns of each category.R: Found returns of each category in Aug. 2021
2.	Plot Correlation Matrix.R: Correlation Matrix Analysis on Portfolio of Aug. 2021
 

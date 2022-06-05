#Finding returns of each category in Aug. 2021
#2021 8 consider
dat_2021_8 = list_all[["2021 8"]]$weights[list_all[["2021 8"]]$weights > 0.00]
list_2021_8 = names(dat_2021_8)
cor_2021_8 = cor(datalist[["2021 8"]][names(datalist[["2021 8"]]) %in% list_2021_8])
# Insignificant correlations are leaved blank


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

stock_side = 0
ffr_side = 0
nft_side = 0
nft_token_side = 0
crypto_side = 0
sp500_side = 0
bond_side = 0
for(j in 1 : ncol(cor_2021_8))
{
  if(names(dat_2021_8[j]) %in% stock_list)
  {
    stock_side = stock_side + dat_2021_8[j]*datalist[["2021 8"]][,names(dat_2021_8[j])]
  }
  else if(names(dat_2021_8[j]) %in% ffr_list)
  {
    ffr_side = ffr_side + dat_2021_8[j]*datalist[["2021 8"]][,names(dat_2021_8[j])]
  }
  else if(names(dat_2021_8[j]) %in% nft_list)
  {
    nft_side = nft_side + dat_2021_8[j]*datalist[["2021 8"]][,names(dat_2021_8[j])]
  }
  else if(names(dat_2021_8[j]) %in% nft_token_list)
  {
    nft_token_side = nft_token_side + dat_2021_8[j]*datalist[["2021 8"]][,names(dat_2021_8[j])]
  }
  else if(names(dat_2021_8[j]) %in% crypto_list)
  {
    crypto_side = crypto_side + dat_2021_8[j]*datalist[["2021 8"]][,names(dat_2021_8[j])]
  }
  else if(names(dat_2021_8[j]) %in% sp500_list)
  {
    sp500_side = sp500_side + dat_2021_8[j]*datalist[["2021 8"]][,names(dat_2021_8[j])]
  }
  else if(names(dat_2021_8[j]) %in% bond_list)
  {
    bond_side = bond_side + dat_2021_8[j]*datalist[["2021 8"]][,names(dat_2021_8[j])]
  }
}


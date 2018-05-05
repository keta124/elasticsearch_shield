class PlatformsController < ApplicationController
  #before_action :authenticate_user!

  def bittrex
    respond_to do |format|
      format.html
      format.json do
        coins = ["BTC","BCC","DASH","ETH","GBYTE","ZEC","XMR","BTCD","LTC","BTG","GNO","DGD","SLS","MLN","DCR","XZC","REP","OMNI","NEO","QTUM","ZEN","FCT","BLOCK","XCP","ETC","NMR","CLOAK","GAM","LSK","MCO","DMD","PART","STRAT","APX","OMG","WAVES","LUN","PIVX","KMD","MONA","SALT","CLAM","SBD","RADS","ZCL","MTL","VTC","KORE","SHIFT","ARK","VRM","NEOS","IOP","SPHR","EXP","SIB","PAY","SWT","PPC","TKS","UBQ","DYN","BNT","ANT","GAME","AEON","CLUB","NXS","TX","STEEM","VIA","IOC","BLITZ","CRW","ION","AGRS","EMC","EXCL","SNRG","EDG","NAV","GEO","TRIG","MYST","ADX","GRS","SWIFT","NXT","UNB","ARDR","QRL","BSD","ENG","STORJ","AUR","BRX","RBY","DCT","XST","XVC","INFX","PKB","TIX","LGD","NBT","FAIR","BYC","DTB","XRP","RLC","EMC2","WINGS","XEM","VRC","POWR","MAID","1ST","ERC","SYNX","CVC","AMP","MEME","BCY","RISE","MER","SYS","BLK","GNT","CPC","GUP","LBC","CURE","XEL","XMG","OK","SPR","EGC","SLR","CRB","HMQ","TRST","PTOY","VTR","VIB","INCNT","BRK","ADA","SEQ","FTC","NXC","VOX","BAT","THC","MUE","POT","EFL","RCN","QWARK","GOLOS","GLD","XVG","EBST","GCR","TRUST","XWC","BAY","GBG","XLM","CFI","ENRG","PDC","NLG","FLO","START","SNGLS","SNT","XAUR","DOPE","LMC","GRC","DNT","CANN","MANA","PTC","DGB","FLDC","BURST","PINK","FUN","ADT","MUSIC","XDN","COVAL","SC","ABY","2GIVE","XMY","BITB","RDD","DOGE"]
        h = { data: [] }
        coins.each do |coin|
          h[:data] << [
            coin,
            Rails.cache.read("bittrex_#{coin}_btc_last") || 0,
            Rails.cache.read("bittrex_#{coin}_btc_high") || 0,
            Rails.cache.read("bittrex_#{coin}_btc_low") || 0,
            Rails.cache.read("bittrex_#{coin}_usd_last") || 0,
            Rails.cache.read("bittrex_#{coin}_usd_high") || 0,
            Rails.cache.read("bittrex_#{coin}_usd_low") || 0,
            Rails.cache.read("bittrex_#{coin}_vnd_last").to_i,
            Rails.cache.read("bittrex_#{coin}_vnd_high").to_i,
            Rails.cache.read("bittrex_#{coin}_vnd_low").to_i,
          ]
        end
        render json: h
      end
    end
  end

end

class LivePriceController < BaseController
  include ActionView::Helpers::NumberHelper

  def index
    ec = ExchangeCoin.where(market: params[:market], coin: params[:coin]).last
    render json: {
      btc: number_with_delimiter(ec.price_btc.to_s),
      usd: number_with_delimiter(ec.price_usd.to_s),
      usdt: number_with_delimiter(ec.price_usdt.to_s),
      vnd: number_with_delimiter(ec.price_vnd.to_i.to_s),
    }
  end
  def show_price 
    market = params[:market]
    case market
    when'coinbase'
      coins = ['BTC', 'ETH', 'LTC']
    when 'gdax'
      coins = ['BTC', 'ETH', 'LTC', 'BCH']
    when 'bittrex'
      coins = ["BTC","BCC","DASH","ETH","GBYTE","ZEC","XMR","BTCD","LTC","BTG","GNO","DGD","SLS","MLN","DCR","XZC","REP","OMNI","NEO","QTUM","ZEN","FCT","BLOCK","XCP","ETC","NMR","CLOAK","GAM","LSK","MCO","DMD","PART","STRAT","APX","OMG","WAVES","LUN","PIVX","KMD","MONA","SALT","CLAM","SBD","RADS","ZCL","MTL","VTC","KORE","SHIFT","ARK","VRM","NEOS","IOP","SPHR","EXP","SIB","PAY","SWT","PPC","TKS","UBQ","DYN","BNT","ANT","GAME","AEON","CLUB","NXS","TX","STEEM","VIA","IOC","BLITZ","CRW","ION","AGRS","EMC","EXCL","SNRG","EDG","NAV","GEO","TRIG","MYST","ADX","GRS","SWIFT","NXT","UNB","ARDR","QRL","BSD","ENG","STORJ","AUR","BRX","RBY","DCT","XST","XVC","INFX","PKB","TIX","LGD","NBT","FAIR","BYC","DTB","XRP","RLC","EMC2","WINGS","XEM","VRC","POWR","MAID","1ST","ERC","SYNX","CVC","AMP","MEME","BCY","RISE","MER","SYS","BLK","GNT","CPC","GUP","LBC","CURE","XEL","XMG","OK","SPR","EGC","SLR","CRB","HMQ","TRST","PTOY","VTR","VIB","INCNT","BRK","ADA","SEQ","FTC","NXC","VOX","BAT","THC","MUE","POT","EFL","RCN","QWARK","GOLOS","GLD","XVG","EBST","GCR","TRUST","XWC","BAY","GBG","XLM","CFI","ENRG","PDC","NLG","FLO","START","SNGLS","SNT","XAUR","DOPE","LMC","GRC","DNT","CANN","MANA","PTC","DGB","FLDC","BURST","PINK","FUN","ADT","MUSIC","XDN","COVAL","SC","ABY","2GIVE","XMY","BITB","RDD","DOGE"]
    when 'hitbtc'
      coins = ["BTC","BCH","DASH","ETH","ZEC","B2X","VERI","XMR","LTC","BTG","BCC","S","GNO","SMS","DGD","REP","NEO","HSR","PPT","ICOS","ETC","TIME","LSK","WAVES","PLU","STRAT","LUN","BTX","OMG","WTC","BUS","SBD","XUC","EOS","TBT","NEBL","OTN","DBIX","GRPH","TAAS","STEEM","PLBT","CNX","PPC","PAY","XTZ","BQX","SUR","SWT","WTT","GAME","BNT","AEON","ANT","ICX","EDO","CTR","EMC","ETP","BOS","ORME","EDG","EVX","ICN","DICE","NXT","ARDR","POLL","LAT","DCT","AE","RLC","VEN","ARN","ZRC","XRP","ETBS","XEM","WINGS","TKN","UGT","MAID","1ST","EMGO","PRG","BMC","LOC","SUB","PING","ODN","DLT","GUP","AMP","MCAP","ZRX","STX","ATB","OAX","IXT","AMM","RVT","TRST","MNE","PTOY","DRPU","ART","MIPS","VIB","FCN","QAU","NXC","ENEW","CL","AMB","BTM","CSNO","LRC","YOYOW","SCL","WMGO","PLR","COSS","XVG","ITS","SMART","PRS","FYP","SNC","CFI","MTH","SNGLS","OTX","ATL","ELM","XAUR","ENJ","VIBE","ZAP","FUEL","XLC","SNT","CLD","DOV","TNT","WRC","KBR","ERO","HVN","CDT","PIX","BKB","CAT","DNT","ELE","FRD","DGB","SC","LEND","FUN","HPC","CND","KICK","STU","ICO","HAC","DSH","CTX","TRX","POE","XDN","QCN","ZSC","CAPP","STORM","ATS","XDNCO","AIR","ATM","INDI","BMT","PRE","EOLD","SISA","OPT","EXN","SKIN","A","TGT","VOISE","NTO","DOGE","SWFTC","BCN","LIFE"]
    when 'poloniex'
      coins = ["BTC","BCH","DASH","ETH","ZEC","XMR","BTCD","LTC","GNO","XBC","DCR","REP","OMNI","FCT","XCP","ETC","GAS","LSK","STRAT","OMG","CLAM","SBD","RADS","VTC","NEOS","EXP","PPC","GAME","NMC","STEEM","VIA","NAV","NXT","BTM","ARDR","PASC","STORJ","XRP","XEM","EMC2","VRC","MAID","BCY","XVC","CVC","SYS","BLK","GNT","AMP","ZRX","LBC","BTS","XPM","NXC","BELA","POT","HUC","STR","RIC","FLO","GRC","DGB","FLDC","BURST","PINK","SC","DOGE","BCN"]
    when 'cryptopia'
      coins = ["42","BTC","BCH","CEFS","DASH","GBYTE","ETH","300","ZEC","XMR","BTCD","GNO","LTC","XBC","XZC","DCR","ATH","NEO","ZCL","UNO","REP","FCT","ZEN","GBX","SKY","ABC","BTB","CLOAK","ALT","ETC","BTX","HSR","TER","OMG","ITI","APX","STRAT","TRI","CMP","CLAM","PIVX","CRC","KMD","LUX","SAGA","WEED","DBIX","BWK","MTL","OTN","GEO","NEBL","HUSH","NVC","ARK","NMS","HBC","MYB","UBQ","VIVO","SHRM","ONION","INN","VRM","CRAVE","PPC","EXP","BTG","SUMO","MAGE","SIB","XSPEC","ZER","IZE","PHR","GAME","BIS","NMC","PAY","AU","XMCC","DIVX","CTR","MONK","CBX","DNR","NAV","POLL","DGPT","ZOI","NXS","EMC","KNC","TX","XPTX","HEAT","PASC","TOK","BKCAT","AUR","PIRL","GRWI","ORME","INFX","PBL","XMG","AURS","PR","KRB","SPR","GRS","UNIT","RBY","SEL","BUCKS","POWR","BSD","BNC","HST","MGX","XEM","MAGN","ALIS","DALC","MGO","PEPE","TIX","R","RKC","EC","XST","ELLA","VRC","MAID","WC","DUO","GNT","RIYA","PRL","LBC","BON","EMC2","WILD","EQT","BLK","DRP","GPL","POSW","AMP","LCP","XPM","XBY","SYNX","MNE","WISH","HC","HAV","PCOIN","611","OK","ODN","DNA","STRC","CREA","XFT","BOP","EGC","STN","BCPT","8BIT","SQL","DBET","BPL","LINX","COR","ADST","PURA","LTB","BTDX","BRO","SEND","ORB","PLR","CRYPT","CHC","RC","PASL","ETHD","FTC","MOIN","CCN","SCL","DEUS","SBC","NTRN","SMART","BTM","BTA","POT","EVR","MST","RPC","EFL","QWARK","NLC2","NETKO","CANN","UFR","RUP","MSP","XID","JET","GLD","ECO","TRC","XCPO","UNIFY","BAY","UNIC","XBL","SPANK","MTNC","IXC","HXX","CNNC","GP","ELC","NDAO","DOPE","MCI","21M","IQT","SXC","START","FRC","DDF","ETT","ACOIN","HDLB","ARCO","KUSH","DPP","ENJ","INSN","TRUMP","SWING","CMT","MAR","DP","TZC","ZAP","ALEX","DARK","RNS","ATMS","UNITS","BCF","GAP","CAPP","BIP","ARC","KEK","XVG","SLG","YOVI","PTC","DAS","BDL","ACC","IFT","I0C","HAL","XLC","MBRS","XBTS","BTCS","LTCU","MEC","MNM","KBR","EDRC","XCXT","SMC","PHS","OFF","BITS","ATOM","ETN","PINK","DGC","FRN","HOLD","EVO","OPAL","CFT","CAT","STV","MAC","DSH","UIS","MATRX","NEVA","BOLI","DGB","SOIL","SKC","SPACE","NOTE","OOO","MOJO","GAY","ARGUS","4CHN","CXT","KOBO","ZSE","MUSIC","IMS","HAC","FORT","RAIN","UMO","CRM","STC","QTL","WDC","CACH","SAFEX","SDRN","KURT","FUZZ","DEM","COAL","CC","WRC","ELM","FLAX","ALL","UTC","CTIC3","BLC","GAIA","KRONE","PXI","BSTY","ARG","TAJ","TES","ECOB","MINEX","FLASH","XGR","PLX","KED","LBTC","VOISE","KING","FAZZ","XJO","DFS","BVC","ERY","TIT","POST","XPD","QRK","SRC","MARS","EVIL","EUC","EMD","SCORE","ABY","PUT","XCO","KDC","DOT","MOTO","XMY","FST","WW","CDN","PROC","RICKS","SOON","HBN","PAK","GRN","SKIN","PXC","RED","BITB","RDD","SFC","HYP","VCC","CHESS","GEERT","EBG","ZET","FUEL","DRXNE","BUMBA","TGC","OPC","KASH","XRE","CPN","FLT","LIZI","LEMON","BVB","EDDIE","BERN","DOGE","XCRE","CNO","OSC","CON","VIDZ","IRL","C2","BXC","TOA","CRX","888","AC","SPT","GPU","XRA","SKR","FCN","CMPCO","LIT","BEST","BEEZ","TRK","BENJI","ADC","$$$","GRW","TSE","SAND","LDC","QBT","KGB","VUC","SAK","PCC","XCT","KAYI","Q2C","WSX","V","WLC","SONG","NYAN","BNX","EDC","GUN","ICOB","ARI","MARX","XGOX","TOP","DON","COPPER","SHA","RBT","PLC","MCRN","DAXX","MTLMC","UR","PIGGY","FONZ","FJC","CQST","CFC","NET","LINDA","DCY","CJ","NOBL","MZC","MINT","LANA","IN","CAR","CAP","TTC","MLITE","ANI","ZEIT","XRY","TEK","OX","NKA","NAMO","LEPEN","LDOGE","IFLT","FFC","EMB","DCN","CRUR","CORG","COMP","CHIEF","808","1337","HLM"]
    end
    h={}
    coins.each do |coin|
      ec = ExchangeCoin.where(market: market,coin: coin).last
      h[coin] = {
        'price_btc'=> (ec.price_btc if defined?(ec.price_btc))||0,
        'price_usd'=> (ec.price_usd if defined?(ec.price_usd))||0,
        'price_vnd'=> (ec.price_vnd.to_i if defined?(ec.price_vnd))||0
      }
    end
    #k =h.sort_by { |k, v| v["price_btc"].to_f }.reverse
    #render json:{coin: k.to_h.keys}
    #render json: k.to_h.to_json
    
    render json: h.to_json
  end
end

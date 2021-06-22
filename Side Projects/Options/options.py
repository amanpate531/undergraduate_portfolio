from yahoo_fin import options
from yahoo_fin import stock_info as stock
import pandas as pd
from datetime import date
import calendar
import math
import mibian

def prob_profit(c_b, c_w, p_w, p_b):
    credit = -1*c_b["Ask"]+c_w["Bid"]+p_w["Bid"]-p_b["Ask"]
    width = c_w["Strike"]-p_w["Strike"]
    return credit, 1-(credit/width)

def find_bestIronCondor(ticker):

    print(ticker)
    price = stock.get_live_price(ticker)

    credProbRatio = cpcb = cpcw = cppb = cppw = cpprob = cpcred = 0
    
    df = options.get_options_chain(ticker)

    dfc = df["calls"]
    dfp = df["puts"]

    calls = pd.merge(dfc[dfc["Strike"] <= math.ceil(price) + 0.03*price], dfc[dfc["Strike"] >= math.ceil(price)-0.5])
    puts = pd.merge(dfp[dfp["Strike"] <= math.floor(price)], dfp[dfp["Strike"] >= math.floor(price) - 0.03*price])

    print(calls.shape[0])
    print(puts.shape[0])
    for w in range(0, calls.shape[0]):
        for x in range(w+1, calls.shape[0]):
            for y in range(0, puts.shape[0]):
                for z in range(y+1, puts.shape[0]):
                    c_b = calls.loc[x]
                    c_w = calls.loc[w]
                    p_w = puts.loc[z]
                    p_b = puts.loc[y]
                    if p_w["Strike"]-p_b["Strike"] != c_b["Strike"]-c_w["Strike"]:
                        continue
                    if p_w["Strike"]-p_b["Strike"] > 10:
                        continue
                    if abs(price - p_w["Strike"] - (c_w["Strike"] - price)) > 0.03*price:
                        continue
                    credit, prob = prob_profit(c_b, c_w, p_w, p_b)
                    if credit / (p_w["Strike"]-p_b["Strike"]) < 0.4:
                        continue
                    if prob < 0.7:
                        continue
                    if credit / prob > credProbRatio:
                        cpcb = c_b["Strike"]
                        cpcw = c_w["Strike"]
                        cppb = p_b["Strike"]
                        cppw = p_w["Strike"]
                        cpprob = prob
                        cpcred = credit

    return [ticker, cpcb, cpcw, cppw, cppb, cpprob, cpcred]

tickers = ["wmt"]
#, "amzn", "baba", "crm", "dis", "fb", "googl", "hd", "jnj", "ma", "msft", "nflx", "nvda", "pcln", "wmt"

iron_condors = []
for x in tickers:
    iron_condors.append(find_bestIronCondor(x))
print(iron_condors)


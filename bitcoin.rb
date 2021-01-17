require './method'

#１日の注文は１以上行わない

MAX_TRADING_COUNT = 1

while(1)
    time_now = Time.now.to_s
    puts "現在の価格：  #{get_price}" +" "+  "#{time_now}"
    sleep(1)
    puts "日本円総額：#{get_balance("JPY")["amount"]}"
    puts "BitCoin総額：　#{get_balance("JPY")}"
end


# get_balance("JPY")["amount"]
# get_balance("BTC")
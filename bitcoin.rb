require './bitflyer_method'
require 'logger'
require './line_notification'

MAX_TRADING_COUNT = 1 #１日の処理実行回数は１回まで
MINIMUM_PURCHASE_UNIT = 0.001 #ビットコインの最低購入単位

result = ""
log = Logger.new('./logfile')

log.info('月次仮想通貨売買を開始')

# 現在の板情報を取得
price = get_price["mid_price"]
puts "現在の1BitCoin価格は #{price}"

# 現在の資産価格を取得
my_btc = get_balance("BTC")
my_jpy = get_balance("JPY")
puts "現在の保有資産(BTC): #{my_btc} btc"
puts "現在の保有資産(JPY): #{my_jpy} 円"
log.info("現在の保有資産: BTC:#{my_btc}, JPY:#{my_jpy}")

# 最低購入金額
minimum_purchase_amount = (price * MINIMUM_PURCHASE_UNIT).ceil
puts "最低購入金額は #{minimum_purchase_amount} 円"
log.info("最低購入金額 #{minimum_purchase_amount}")

# 購入する
puts "購入処理を行います"
sleep(1)

# もし、現在の資産価格(円)が足りなければ、エラーを通知
if my_jpy < minimum_purchase_amount
    result =  "残高不足です。注文を中止します。保有資産(JPY): #{my_jpy}円,最低購入金額: #{minimum_purchase_amount}円"
    log.error('注文失敗(残高不足)')
else 
    begin
        buy_order
        result =  "注文が完了しました"
        log.info('注文成功')
    rescue Exeption => e
        result = "注文失敗 #{e.class}"
        log.info("注文失敗 #{e.class}")
    end
end

# 結果をLINEで送信
LineNotify.send(result)


require 'net/http'
require 'uri'
require 'json'
require './key'
require 'byebug'

# 現在価格表示(API_SECRET不要)
uri = URI.parse("https://api.bitflyer.com")
uri.path = '/v1/getboard'


https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true
response = https.get uri.request_uri
puts response.body

#json形式からハッシュに変換する
response_hash = JSON.parse(response.body)
puts response_hash["mid_price"]
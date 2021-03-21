require 'net/http'
require 'uri'
require './key'

class LineNotify
  #.freezeで定数の意図しない書き換えを防ぐ
  URL_TEXT = 'https://notify-api.line.me/api/notify'.freeze

  attr_reader :message

  #送信処理の呼び出し口
  def self.send(message)
    new(message).send
  end

  def initialize(message)
    @message = message
  end

  def send
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |https|
      https.request(request)
    end
  end

  private

  def request
    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{TOKEN}"
    request.set_form_data(message: message)
    request
  end

  def uri
    URI.parse(URL_TEXT)
  end
end

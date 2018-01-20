# coding: utf-8

class GetTransactionList
  prepend SimpleCommand
  attr_accessor :address

  def initialize(address)
    @address = address
  end

  def call
    @response = RestClient.get "http://rinkeby.etherscan.io/api", params: {
      module: 'account',
      action: 'txlist',
      address: @address,
      startblock: 0,
      endblock: 145900,
      sort: 'asc',
      apikey: 'KRZ3YKTYGI6YMSGMMKYVRPIC18AX1B6MDQ'
    }

  rescue => exception
    errors.add(:transactions, exception.to_s)
  else
    JSON.parse(@response)
  end
end

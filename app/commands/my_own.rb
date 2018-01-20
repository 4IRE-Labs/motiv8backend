class MyOwn
  def initialize
  end

  def tnx_list(address)
    response = RestClient.get "http://rinkeby.etherscan.io/api", params: {
      module: 'account',
      action: 'txlist',
      address: address,
      startblock: 0,
      endblock: 1459000,
      sort: 'asc',
      apikey: 'KRZ3YKTYGI6YMSGMMKYVRPIC18AX1B6MDQ'
    }

    JSON.parse(response)
  end


  def txn_check(address)
    @donations = Wallet.all

    @found_transactions = []

    @transactions = MyOwn.new.tnx_list(address)

    @transactions['result'].each do |tnx|
      @donations.each do |don|
        @found_transactions << tnx['to'] if don.address == tnx['to']
      end
    end

    @found_transactions
    send_to_smartcontract(@found_transactions, address)
  end

  def send_to_smartcontract(donations, address)
    donations.each do |don|
      system("venv/bin/python app.py --owner #{address} --tx #{don} --title 'Finallyy !!!'")
    end
  end
end
class MyOwn
  def initialize
    @my_logger ||= Logger.new("#{Rails.root}/log/trans.log")
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
        if don.address == tnx['to']
          @found_transactions << { challegnge: tnx['to'], tnx: tnx['hash'] }
        end
      end
    end
    send_to_smart_contract(@found_transactions, address)
  end

  def claim_one_badge(challenge, address)

    found_transactions = []
    all_trans = tnx_list(address)
    all_trans['result'].each do |tnx|
      begin
        if tnx['to'] == challenge.address
          found_transactions << { challegnge: tnx['to'], tnx: tnx['hash'] }
        end
      rescue => error
        @my_logger.info "claim_one_badge: #{error}"
      end
    end

    send_to_smart_contract(found_transactions, address)
  end

  def send_to_smart_contract(donations, address)
    # for the test
    # address = '0xFAb1B5373DF39113d81977169394B0cAe97642cC'
    # donations = [{ challegnge: '0x99a4572656eb49FFEEFbe9588f8e7ab0F8D6Eb5e', tnx: '123123134535299999999' }]

    donations.each do |don|
      begin
        p "SEND TO --owner #{address} --tx #{don[:tnx]} --challenge #{don[:challegnge]}"
        system("venv/bin/python app.py --owner #{address} --tx #{don[:tnx]} --challenge #{don[:challegnge]}")
      rescue => error
        @my_logger.info "send_to_smart_contract: #{error}"
      end
    end
  end
end
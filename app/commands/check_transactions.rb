# coding: utf-8

class CheckTransactions
  prepend SimpleCommand
  attr_accessor :transactions

  def initialize(transactions)
    @donations = Wallet.all
    @transactions = transactions
  end

  def call

    @found_transactions = []

    @transactions['result'].each do |tnx|
      @donations.each do |don|
        @transactions << tnx['to'] if don.address == tnx['to']
      end
    end

    @found_transactions
  rescue => exception
    errors.add(:transactions, exception.to_s)
  else
    @found_transactions
  end
end

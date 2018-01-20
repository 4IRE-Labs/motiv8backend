# coding: utf-8

class FindTransactions
  prepend SimpleCommand
  attr_accessor :address

  def initialize(address)
    @address = address
  end

  def call
    command = GetTransactionList.call(@address)
    if command.success?
      @respond = CheckTransactions.call(command.result)
      if @respond.success?
        @respond = @respond.result
      end
    end

  rescue => exception
    errors.add(:transactions, exception.to_s)
  else
    @respond
  end
end

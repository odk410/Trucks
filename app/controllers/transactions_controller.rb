class TransactionsController < ApplicationController
  def account_inquiry
    account = params[:acc]
    # UtilityHelper::printArgs(account)
    @account = Account.find_by_acc_num(account)
    unless @account.nil?
      @trx = @account.transactions
    else
      render_404 
    end
  end
end

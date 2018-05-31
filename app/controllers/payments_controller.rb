class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  # # GET /payments
  # # GET /payments.json
  # def index
  #   @payments = Payment.all
  # end

  # # GET /payments/1
  # # GET /payments/1.json
  # def show
  # end

  # GET /payments/new
  def new
    if user_signed_in?
      celeb = Celebrity.find(params[:celeb])
      @payment = Payment.new(
        pg_provider: 'paypal',
        pay_method: 'card',
        merchant_uid: 'merchant_'+celeb.id.to_s+'_'+DateTime.now.strftime("%Y%d%m%H%M%S").to_s,
        name: celeb.name+' 이름으로 기부와 행사 응모권',
        amount: params[:amount].to_i/1000, # USD
        status: 'preorder',
        user_id: current_user.id
      )
      respond_modal_with @payment
    end
    # :imp_uid, :pg_provider, :amount, :name, :pay_method, :status, :merchant_uid, :user_id,
    # UtilityHelper::printArgs(params[:amount])

  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    UtilityHelper::printArgs(payment_params)
    @payment.save
    celeb_id = @payment.merchant_uid.split('_')[1]
    redirect_to celebrity_path(Celebrity.find(celeb_id))

    # respond_to do |format|
    #   if @payment.save
    #     format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
    #     format.json { render :show, status: :created, location: @payment }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @payment.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # # PATCH/PUT /payments/1
  # # PATCH/PUT /payments/1.json
  # def update
  #   respond_to do |format|
  #     if @payment.update(payment_params)
  #       format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @payment }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @payment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /payments/1
  # # DELETE /payments/1.json
  # def destroy
  #   @payment.destroy
  #   respond_to do |format|
  #     format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:imp_uid, :pg_provider, :amount, :name, :pay_method, :status, :merchant_uid, :user_id, :cancel_reason, :cancelled_at, :cancel_amount, :paid_at, :fail_reason, :failed_at, :pg_tid)
    end
end

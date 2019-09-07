class WalletController < ApplicationController
  before_action :authenticate_user!
  rescue_from Stripe::CardError, with: :catch_exception
  def index
  end

  def new
  end

  def new_card
  end

  def add
    @wallet_amount = params[:user][:wallet_amount]
    StripeChargesServices.new(params[:stripeToken], current_user.email, current_user, @wallet_amount).call
  end
  def charges_params
    params.permit(:stripeEmail, :stripeToken, :order_id)
  end

  def catch_exception(exception)
    flash[:error] = exception.message
    redirect_to root_path
  end

end

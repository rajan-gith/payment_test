class SubscribesController < ApplicationController
  rescue_from Stripe::CardError, with: :catch_exception
  def new
    if current_user.stripe_id.nil?
      customer = Stripe::Customer.create({"email": current_user.email})
      #here we are creating a stripe customer with the help of the Stripe library and pass as parameter email.
      current_user.update(:stripe_id => customer.id)
      #we are updating current_user and giving to it stripe_id which is equal to id of customer on Stripe
    end
  end

  def recharge
    if current_user.stripe_id.nil?
      redirect_to root_path, :flash => {:error => 'Firstly you need to enter your card'}
      return
    end

    if current_user.wallet_amount < 200
      result = ChargeService.new(current_user.email, current_user, 500).call
      if result["paid"] == true
        redirect_to subscribe_path, :flash => {:info => 'Charged successfully'}
      else
        redirect_to subscribe_path, :flash => {:info => 'could not pay'}
      end
    else
      redirect_to root_path, :flash => {:error => 'You have sufficient balance '}
    end

  end
  def catch_exception(exception)
    flash[:error] = exception.message
    redirect_to root_path and return
  end
end

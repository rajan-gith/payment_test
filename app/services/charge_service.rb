class ChargeService
  DEFAULT_CURRENCY = 'usd'.freeze

  def initialize(stripeEmail, user, amount)
    @stripe_email = stripeEmail
    @amount = (amount.to_i * 100)
    @user = user
  end

  def call
    create_charge(find_customer)
  end

  private

  attr_accessor :user, :stripe_email, :stripe_token, :amount

  def find_customer
    if user.stripe_id
      retrieve_customer(user.stripe_id)
    else
      create_customer
    end
  end

  def retrieve_customer(stripe_token)
    Stripe::Customer.retrieve(stripe_token)
  end

  def create_customer
    customer = Stripe::Customer.create(
      email: stripe_email,
    )
    user.update(stripe_id: customer.id)
    customer
  end

  def create_charge(customer)
    charge = Stripe::Charge.create(
              customer: customer.id,
              amount: amount,
              description: customer.email,
              currency: DEFAULT_CURRENCY
            )
    if charge["paid"] == true
      user.wallet_amount += amount/100
      user.save
    end
    return charge
  end

end

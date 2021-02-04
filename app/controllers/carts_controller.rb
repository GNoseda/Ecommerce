class CartsController < ApplicationController
  before_action :authenticate_user!

  def update
    product = params[:cart][:product_id]
    quantity = params[:cart][:quantity]

    current_order.add_product(product, quantity)
    redirect_to root_url, notice: "Product added successfuly"
  end

  def show
    @order = current_order
  end

  def pay_with_paypal
    order = Order.find(params[:cart][:order_id])

    #price must be in cents
    price = order.total_cents

    response = get_purchase_response(price)

    payment_method = PaymentMethod.find_by(code: "PEC")

    Payment.create_payment(order, payment_method, response)

    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end



  def process_paypal_payment
    details = EXPRESS_GATEWAY.details_for(params[:token])    
    price = details.params["order_total"].to_d * 100

    express_purchase_options =
      {
        ip: request.remote_ip,
        token: params[:token],
        payer_id: details.payer_id,
        currency: "USD"
      }

    response = EXPRESS_GATEWAY.purchase(price, express_purchase_options)
    
    if response.success?
      payment = Payment.find_by(token: response.token)
      
      #update object states
      payment.update_states
    end
  end

  private
  
  def get_purchase_response(order_price)
    EXPRESS_GATEWAY.setup_purchase(order_price,
      ip: request.remote_ip,
      return_url: process_paypal_payment_cart_url,
      cancel_return_url: root_url,
      allow_guest_checkout: true,
      currency: "USD"
    )
  end
end

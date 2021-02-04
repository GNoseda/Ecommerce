require 'rails_helper'

RSpec.describe Payment, type: :model do
  it 'Updates self state' do
    user_01 = User.create(email:"test@example.com", password:"123456", password_confirmation:"123456" )
    order_01 = Order.create(user_id:1, number:"0001", total:"10000", state:"pending")
    payment_method_01 = PaymentMethod.create(name:"name", code:"code")
    payment_01 = Payment.create(order_id:1, payment_method_id:1, state:"pending", total:"10000", token:"A001")

    payment_01.update_states
    expect(payment_01.state).to  eq("completed")
  end

  it 'Updates order state' do
    user_01 = User.create(email:"test@example.com", password:"123456", password_confirmation:"123456" )
    order_01 = Order.create(user_id:1, number:"0001", total:"10000", state:"pending")
    payment_method_01 = PaymentMethod.create(name:"name", code:"code")
    payment_01 = Payment.create(order_id:1, payment_method_id:1, state:"processing", total:"10000", token:"A001")

    payment_01.update_states
    expect(order_01.state).to  eq("completed")
  end

  it 'Creates Payment' do
    order_01 = Order.create(user_id:1, number:"0001", total:"10000", state:"pending")
    payment_method_01 = PaymentMethod.create(name:"name", code:"code")
    payment_01 = Payment.create(order_id:1, payment_method_id:1, state:"processing", total:"10000", token:"A001")
    response = get_purchase_response(10000)

    expect(create_payment(order, payment_method, response)).to change(Payment.count).by(1)
  end
end

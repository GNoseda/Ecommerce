class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :payment_method

  def self.create_payment(order, payment_method, response)
    Payment.create(
      order_id: order.id,
      payment_method_id: payment_method.id,
      state: "processing",
      total: order.total,
      token: response.token
    )
  end

  def update_states
    order = self.order

    #update object states
    self.state = "completed"
    order.state = "completed"
    
    ActiveRecord::Base.transaction do
      order.save!
      self.save!
    end
  end
end

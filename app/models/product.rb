class Product < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items

  belongs_to :mainproduct
  
  has_many :compositions
  has_many :variants, through: :compositions
  accepts_nested_attributes_for :compositions


end


class Product < ApplicationRecord
  has_and_belongs_to_many :categories

  has_many :order_items
  has_many :orders, through: :order_items

  has_many :product_variants
  has_many :variants, through: :product_variants
  accepts_nested_attributes_for :product_variants

  def catalogue
    self.stock > 0 
  end

  def self.choose_index
    indx = Product.all
  end
end


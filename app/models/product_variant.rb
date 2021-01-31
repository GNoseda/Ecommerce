class ProductVariant < ApplicationRecord
  belongs_to :product
  belongs_to :variant
end

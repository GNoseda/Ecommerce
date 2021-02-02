class Variant < ApplicationRecord
    has_many :compositions
    has_many :products, through: :compositions
end

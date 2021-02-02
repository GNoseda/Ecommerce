class Mainproduct < ApplicationRecord
    has_and_belongs_to_many :categories

    has_many :products

    def catalog
        abled = false
        self.products.each do |prod|
            abled = true if prod.stock > 0
        end
        abled
    end

    def show_catalog
        options = []
        self.products.each do |prod|
            options << prod if prod.stock > 0
        end
        options.first
    end
end

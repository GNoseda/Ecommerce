class AddMasterproductToCategoriesProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :categories_products, :mainproduct, foreign_key: true
  end
end

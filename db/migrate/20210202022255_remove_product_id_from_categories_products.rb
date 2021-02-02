class RemoveProductIdFromCategoriesProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories_products, :product_id
  end
end

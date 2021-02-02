class AddMainproductReferenceToProduct < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :mainproduct, foreign_key: true
  end
end

class CreateCompositions < ActiveRecord::Migration[5.2]
  def change
    create_table :compositions do |t|
      t.string :product_references
      t.references :variant, foreign_key: true

      t.timestamps
    end
  end
end

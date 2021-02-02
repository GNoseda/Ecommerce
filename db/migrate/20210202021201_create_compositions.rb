class CreateCompositions < ActiveRecord::Migration[5.2]
  def change
    create_table :compositions do |t|
      t.references :product, foreign_key: true
      t.references :variant, foreign_key: true

      t.timestamps
    end
  end
end

class CreateMainproducts < ActiveRecord::Migration[5.2]
  def change
    create_table :mainproducts do |t|
      t.string :name

      t.timestamps
    end
  end
end

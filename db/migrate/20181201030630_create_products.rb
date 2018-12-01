class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :asin
      t.references :category, index: true
      t.string :dimensions

      t.timestamps
    end
  end
end

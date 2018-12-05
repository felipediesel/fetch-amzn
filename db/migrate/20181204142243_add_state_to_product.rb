class AddStateToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :state, :string, null: false, default: 'progress'
  end
end

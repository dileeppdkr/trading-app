class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :state, default: 'pending'
      t.decimal :price, precision: 14, scale: 8
      t.decimal :volume, precision: 14, scale: 8
      t.decimal :traded_volume, precision: 14, scale: 8
      t.string :side, default: nil

      t.timestamps
    end
  end
end

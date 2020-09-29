class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name,             null: false
      t.string :size
      t.string :introduction,     null: false
      t.string :category_id,      null: false
      t.string :brand_name
      t.string :condition,        null: false, default: 0
      t.string :status,           null: false, default: 0 #売り切れかそうでないか
      t.string :postage_payer,    null: false, default: 0
      t.string :preparation_day,  null: false,  default: 0
      t.string :shipment_area,    null: false
      t.string :postage_type,     null: false
      t.integer :price,           null: false
      t.timestamps
    end
  end
end

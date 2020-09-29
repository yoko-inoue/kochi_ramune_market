class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :category, null:false, foreign_key: true
      t.string :name,              null: false
      t.string :size
      t.string :introduction,      null: false
      t.string :brand_name
      t.integer :condition,        null: false, default: 0
      t.integer :status,           null: false, default: 0 #売り切れかそうでないか
      t.integer :postage_payer,    null: false, default: 0
      t.integer :preparation_day,  null: false, default: 0
      t.integer :postage_type,     null: false
      t.integer :price,            null: false
      t.integer :prefecture_id,    null: false
      t.timestamps
    end
  end
end


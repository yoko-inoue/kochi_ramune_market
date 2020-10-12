class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :category, null:false, foreign_key: true
      t.references  :user, null: false, foreign_key: true
      t.string :name,              null: false
      t.string :size
      t.string :introduction,      null: false
      t.string :brand_name
      t.integer :condition_id,        null: false, default: 0
      t.integer :postage_payer_id,    null: false, default: 0
      t.integer :preparation_day_id,  null: false, default: 0
      t.integer :postage_type_id,     null: false, default: 0
      t.integer :price,            null: false
      t.integer :prefecture_id,    null: false
      t.timestamps
    end
  end
end


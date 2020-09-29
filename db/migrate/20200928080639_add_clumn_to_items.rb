class AddClumnToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :name, :string, null: false
    add_column :items, :price, :integer, null: false
    add_column :items, :introduction, :string, null: false
    add_column :items, :category_id, :string, null: false
    add_column :items, :brand_name, :string
    add_column :items, :condition, :string, null: false
    add_column :items, :postage_payer, :string, null: false
    add_column :items, :shipment_area, :string, null: false
    add_column :items, :size, :string
    add_column :items, :postage_type, :string, null: false
  end
end

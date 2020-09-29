class Drop < ActiveRecord::Migration[6.0]
  def change
    drop_table :prefectures
    drop_table :images
    drop_table :items
  end
end

class AddUrlToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :image_url, :string, null: false
  end
end

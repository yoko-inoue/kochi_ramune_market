class Addclumntoimages < ActiveRecord::Migration[6.0]
  def change
    add_reference :images, :item, foreign_key: true
  end
end

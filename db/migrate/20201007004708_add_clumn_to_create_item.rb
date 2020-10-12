class AddClumnToCreateItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :buyer, foreign_key: { to_table: :users }
  end
end

class Unique < ActiveRecord::Migration[6.0]
  def change
    remove_index :sending_destinations, :phone_number
    add_index :sending_destinations, :phone_number, unique: true
  end
end
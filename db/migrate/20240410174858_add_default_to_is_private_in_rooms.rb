class AddDefaultToIsPrivateInRooms < ActiveRecord::Migration[7.1]
  def change
    change_column_default :rooms, :is_private, from: nil, to: false
  end
end
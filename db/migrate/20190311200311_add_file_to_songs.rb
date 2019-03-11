class AddFileToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :filename, :string
  end
end

class AddSongFields < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :key_letter, 'char(1)'
    add_column :songs, :key_number, 'tinyint unsigned'
    add_column :songs, :bpm, 'tinyint unsigned'
    add_column :songs, :energy, 'tinyint unsigned'
    add_column :songs, :year, 'smallint unsigned'
    add_column :songs, :genres, 'string'
  end
end

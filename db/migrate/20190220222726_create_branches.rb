class CreateBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :branches, id: false do |t|
      t.integer :song_id, limit: 8, null: false
      t.integer :branch_id, limit: 8, null: false
      t.timestamps
    end

    add_index :branches, %w(song_id branch_id), unique: true
  end
end

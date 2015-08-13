class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.string :artsy_id, null: false
      t.string :slug, null: false
      t.string :thumbnail
      t.integer :page_views
      t.integer :follows
      t.integer :score, null: false, default: 0
      t.timestamps null: false
    end

    add_index :artists, :artsy_id, unique: true
    add_index :artists, :slug, unique: true
    add_index :artists, :score
  end
end

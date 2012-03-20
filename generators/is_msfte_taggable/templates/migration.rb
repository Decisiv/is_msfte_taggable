class CreateTaggables < ActiveRecord::Migration

  def up
    create_table :tags do |t|
      t.string :name, :default => ''
      t.string :kind, :default => ''
      t.timestamps
    end
    create_table :taggings do |t|
      t.integer :tag_id
      t.string  :taggable_type
      t.integer :taggable_id
      t.timestamps
    end
    add_index :tags, :name
    add_index :tags, [:name, :kind], :name => "name_and_kind"
    add_index :taggings, [:taggable_type, :taggable_id], :name => "taggable_interface_index"
  end

  def down
    drop_table :tags
    drop_table :taggings
  end
  
end

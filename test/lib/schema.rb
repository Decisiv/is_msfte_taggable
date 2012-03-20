ActiveRecord::Base.class_eval do
  silence do
    
    connection.create_table :users, :force => true do |t|
      t.string :name, :default => ''
    end
    
    connection.create_table :posts, :force => true do |t|
      t.string  :title, :default => ''
    end
    
    connection.create_table :tags, :force => true do |t|
      t.string :name, :default => ''
      t.string :kind, :default => '' 
    end
    
    connection.create_table :taggings, :force => true do |t|
      t.integer :tag_id
      t.string  :taggable_type, :default => ''
      t.integer :taggable_id
    end

  end
end

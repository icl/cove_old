class CreateCommentings < ActiveRecord::Migration
  def self.up
    create_table :commentings do |t|
      t.references :user
      t.references :interval
      t.references :comment
      
      t.timestamps
    end
  end

  def self.down
    drop_table :commentings
  end
end

class CreateQuestionings < ActiveRecord::Migration
  def self.up
    create_table :questionings do |t|
      t.references :user
      t.references :interval
      t.references :question
      
      t.timestamps
    end
  end

  def self.down
    drop_table :questionings
  end
end

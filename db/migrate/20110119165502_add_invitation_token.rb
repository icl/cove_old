class AddInvitationToken < ActiveRecord::Migration
  def self.up
    add_column :users, :invitation_token, :string
  end

  def self.down
    remove_column :users, :invitation_token
  end
end
class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.string :subjects
      t.text :body
      t.string :contacts

      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end

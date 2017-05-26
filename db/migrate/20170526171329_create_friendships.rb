class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
    t.integer :user_id
    t.integer :friend_id, class: User
    t.timestamp :created_at
    t.timestamp :updated_at
    end
  end
end

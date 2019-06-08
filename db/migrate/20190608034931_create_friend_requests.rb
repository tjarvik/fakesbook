class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.integer :requester_id
      t.integer :requested_id

      t.timestamps
    end
  end
end

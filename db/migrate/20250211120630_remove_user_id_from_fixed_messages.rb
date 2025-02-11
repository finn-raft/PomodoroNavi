class RemoveUserIdFromFixedMessages < ActiveRecord::Migration[7.1]
  def change
    remove_reference :fixed_messages, :user, foreign_key: true
  end
end

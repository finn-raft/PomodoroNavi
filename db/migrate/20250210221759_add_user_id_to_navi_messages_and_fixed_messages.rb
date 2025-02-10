class AddUserIdToNaviMessagesAndFixedMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :navi_messages, :user, null: false, foreign_key: true
    add_reference :fixed_messages, :user, null: false, foreign_key: true
    add_reference :navi_fixed_messages, :user, null: false, foreign_key: true
  end
end

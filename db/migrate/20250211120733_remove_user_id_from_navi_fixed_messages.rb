class RemoveUserIdFromNaviFixedMessages < ActiveRecord::Migration[7.1]
  def change
    remove_reference :navi_fixed_messages, :user, foreign_key: true
  end
end

class CreateNaviMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :navi_messages do |t|
      t.text :user_message
      t.text :response
      t.text :context

      t.timestamps
    end
  end
end

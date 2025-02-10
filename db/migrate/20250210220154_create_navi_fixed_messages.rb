class CreateNaviFixedMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :navi_fixed_messages do |t|
      t.references :navi_message, null: false, foreign_key: true
      t.references :fixed_message, null: false, foreign_key: true

      t.timestamps
    end
  end
end

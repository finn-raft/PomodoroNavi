class CreateFixedMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :fixed_messages do |t|
      t.text :content

      t.timestamps
    end
  end
end

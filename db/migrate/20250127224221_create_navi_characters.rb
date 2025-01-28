class CreateNaviCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :navi_characters do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :first_person_pronoun
      t.string :second_person_pronoun
      t.text :description
      t.string :icon_url

      t.timestamps
    end
  end
end

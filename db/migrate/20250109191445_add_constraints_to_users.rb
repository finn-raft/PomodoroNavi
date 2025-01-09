class AddConstraintsToUsers < ActiveRecord::Migration[7.1]
  def change
    # nameカラムにNOT NULL制約を追加
    change_column_null :users, :name, false

    # nameカラムに長さの制約を追加（最大20文字）
    change_column :users, :name, :string, limit: 20
  end
end

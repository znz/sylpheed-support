class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics, id: :uuid do |t|
      t.text :body, null: false
      t.boolean :delete_flg, null: false, default: false

      t.timestamps
    end
  end
end

class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics, id: :uuid do |t|
      t.text :body
      t.boolean :delete_flg

      t.timestamps
    end
  end
end

class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles, id: :uuid do |t|
      t.integer :article_id
      t.integer :pthread_id
      t.boolean :delete_flg, null: false, default: false
      t.string :password
      t.inet :remote_addr, null: false
      t.string :name, null: false
      t.string :subject, null: false
      t.text :body, null: false
      t.string :mail_addr
      t.string :url

      # awesome_nested_set
      t.uuid :parent_id, null: true, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true

      # optional fields
      t.integer :depth, null: false, default: 0
      t.integer :children_count, null: false, default: 0

      t.timestamps
    end
  end
end

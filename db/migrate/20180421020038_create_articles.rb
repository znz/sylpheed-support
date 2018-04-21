class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles, id: :uuid do |t|
      t.integer :article_id
      t.integer :pthread_id
      t.boolean :delete_flg
      t.string :password
      t.inet :remote_addr
      t.string :name
      t.string :subject
      t.text :body
      t.string :mail_addr
      t.string :url

      t.timestamps
    end
  end
end

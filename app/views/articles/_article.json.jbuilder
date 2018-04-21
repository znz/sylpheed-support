json.extract! article, :id, :article_id, :pthread_id, :delete_flg, :password, :remote_addr, :name, :subject, :body, :mail_addr, :url, :created_at, :updated_at
json.url article_url(article, format: :json)

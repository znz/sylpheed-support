Rails.application.routes.draw do
  resources :articles
  redirect_to_bbs_article = redirect {|path_params, req| "/bbs?#{req.env['QUERY_STRING']}" }
  get '/bbs_article_body.php', to: redirect_to_bbs_article
  get '/bbs_article_index.php', to: redirect_to_bbs_article
  get '/bbs_article.php', to: redirect_to_bbs_article
  get '/bbs.php', to: redirect('/bbs')
  get '/log.php', to: redirect('/')
  resources :topics
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

# coding: utf-8
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.roots
    @articles = @articles.limit(50)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    unless @article.root?
      redirect_to "#{url_for(@article.root)}#id#{@article.id}"
    end
  end

  # GET /articles/new
  def new
    @article = Article.new
    parent = Article.find(params[:parent_id])
    @article.parent = parent
    if Article::ARTICLE_MAX <= parent.root.self_and_descendants.count
      redirect_to parent, notice: "コメント数が#{Article::ARTICLE_MAX}を超えています。これ以上は投稿できません。"
    end
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.remote_addr = request.remote_ip

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def bbs
    h = {}
    h[:pthread_id] = params[:pthread_id].to_i
    article_id = params[:article_id]
    if article_id
      h[:article_id] = article_id.to_i
    end
    redirect_to Article.where(h).first
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:parent_id, :name, :subject, :body, :mail_addr, :url)
    end
end

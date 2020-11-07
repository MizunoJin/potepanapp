class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:new, :edit, :update, :destroy]
  before_action :set_post, only: %i[show edit update destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "投稿されました！"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'top_page/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "削除されました!"
    redirect_to request.referrer || root_url
  end

  def show
    @micropost = Micropost.find_by(id: params[:id])
    @comments = @micropost.comments
    @comment = @micropost.comments.build #投稿全体へのコメント投稿用の変数
    @comment_reply = @micropost.comments.build #コメントに対する返信用の変数
  end
  
  def new
    @micropost = current_user.microposts.build
  end
  
  def edit
  end
  
  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @microposts = Micropost.search(params[:search])
    binding.pry
    render 'search'
  end
  
  private

    def micropost_params
      params.require(:micropost).permit(:content, :image)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
    
    def set_post
      @micropost = Micropost.find(params[:id])
    end
  
    def post_params
      params.require(:micropost).permit(:title, :detail, :micropost_image, :post_image_cache, :deadline, :status, category_ids: [])
    end
end

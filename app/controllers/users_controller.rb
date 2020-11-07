class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy,
                                        :following, :followers, :password_edit, :password_update]
  before_action :correct_user, only: [:edit, :update, :password_edit, :password_update]
  before_action :admin_user,  only: :destroy
  protect_from_forgery :except => [:password_update, :facebook_login]
  
  def new
    @user = User.new
  end
  
  def index
    @users = User.where(activated:true).paginate(page: params[:page])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "受信したEメールから認証手続きを進めてください"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated == true
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールが更新されました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "アカウントが削除されました"
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end
  
  def password_edit
    @user = User.find(params[:id])
  end
  
  def password_update
    @user = User.find(params[:id])
    current_password = params[:user][:current_password]
    new_password = params[:user][:new_password]
    new_password_confirmation = params[:user][:new_password_confirmation]
    if @user.authenticate(current_password) && new_password.present? && new_password == new_password_confirmation
      if @user.update(password: new_password)
        flash[:success] = "パスワードを変更しました"
        redirect_to @user
      else
        flash.now[:danger] = '新しいパスワードが無効です'
        render 'password_edit'
      end
    elsif new_password != new_password_confirmation
      flash[:danger] = 'パスワードが一致しません'
      render 'password_edit'
    else
      flash[:danger] = '現在のパスワードが間違っています'
      render 'password_edit'
    end
  end
  
  def facebook_login
  #@user = User.from_omniauth(request.env["omniauth.auth"])
  @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    if @user.save(context: :facebook_login)
      log_in @user
      redirect_to @user
    else
      redirect_to auth_failure_path
    end
  end
  
  #認証に失敗した際の処理
  def auth_failure 
    @user = User.new
    render 'new'
  end

    private

    def user_params
      params.require(:user).permit(:name, :username, :email, :website, :introduction, :email, :number, :sex, :password, :password_confirmation)
    end

    
    #正しいユーザーか確認する
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
       # 渡されたユーザーでログインする
    def log_in(user)
      session[:user_id] = user.id
    end
end

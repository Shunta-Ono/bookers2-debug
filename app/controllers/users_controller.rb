class UsersController < ApplicationController
  before_action :authenticate_user!, onry: [:index,:show,:new,:edit,:create,:update]
  before_action :set_user, only: [:edit, :show, :update]
  before_action :baria_user, only: [:update,:edit]

  def show
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
  end

  def update
   if @user.update(user_params)
    redirect_to user_path(@user.id), notice: "successfully updated user!"
  else
    render "edit"
  end
end

private
def user_params
 params.require(:user).permit(:name, :introduction, :profile_image)
end

def set_user
  @user = User.find(params[:id])
end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
  def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
  end

end


class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def show
    @book_new = Book.new
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new
  	@books = Book.page(params[:page]).reverse_order
  end

  def create
  	@book = current_user.books.build(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@book.id), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
  end

  def update
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	@book.delete
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def correct_user
    @user = @book.user
    unless @user.id == current_user.id
      redirect_to books_path
    end
  end

  def book_params
  	params.require(:book).permit(:user_id,:title,:body)
  end

  def set_book
    @book = Book.find(params[:id])
  end

end

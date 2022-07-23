class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @book_comments = BookComment.all
    @book_comment = BookComment.new
    
    view_counts = ViewCount.where(book_id: params[:id])

    if (view_counts.empty?)
      #初回閲覧1回目
      @view = 1
      view_counts = ViewCount.new
      view_counts.book_id = params[:id]
      view_counts.view_qty = 1
      view_counts.save
    else
      new_qty = view_counts[0].view_qty + 1
      view_counts.update(view_qty: new_qty)

      @view = new_qty
    end
  end

  def index
    @user = User.find(current_user.id)

    #includes : 紐づくテーブル抜き出し
    @books = Book.includes(:favorited_users, :view_count).
    sort {|a,b| 
      b.favorited_users.size <=> 
      a.favorited_users.size
    }    
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    #binding.irb
    if @book.save
      view_counts = ViewCount.new
      view_counts.book_id = @book.id
      view_counts.view_qty = 0
      view_counts.save


      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
    #params.permit(:title, :body)
  end
end

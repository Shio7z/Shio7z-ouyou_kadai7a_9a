class FavoritesController < ApplicationController
    #いいねON
    def create
      @book = Book.find(params[:book_id])
      @favorite = current_user.favorites.new(book_id: @book.id)
      @favorite.save

      #非同期通信の場合
      #createアクション実行後は、create.js.erbファイルを探す
      #その際、@book.idが参照されるので、@

      # 同期通信はページ遷移
      # if favorite.save
      #   redirect_to books_path(book)
      # else
      #   binding.irb
      # end
    end

    #いいねOFF
    def destroy
      @book = Book.find(params[:book_id])
      @favorite = current_user.favorites.find_by(book_id: @book.id)
      @favorite.destroy

      #非同期通信の場合
      #destroyアクション実行後はdestroy.js.erbファイルを探す
      #その際、@book.idが参照されるので、@

      # 同期通信はページ遷移
      #redirect_to books_path(book)
    end
end

class UsersController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :destory]

  def index
  end

  def show
    @new_items = Item.where(user_id:current_user.id)
    @buy_items = @new_items.order(created_at: :desc).limit(3)
    @items = @user.items
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:item_id)  # ログイン中のユーザーのお気に入りのitem_idカラムを取得(.pluckを使って、bookmarkテーブル内でログインユーザーのidを持ってるitem_idを取得
    @bookmark_list = Item.find(bookmarks)     # bookmarksテーブルから、お気に入り登録済みのレコードを取得
  end

  def edit
  end

  def destory
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  

  
end

class BookmarksController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!   # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）

  def create
    if @item.user_id != current_user.id   # 投稿者本人以外に限定
      @bookmark = Bookmark.create(user_id: current_user.id, item_id: @item.id)
    end
  end

  def destroy
    @bookmark = Bookmark.find_by(user_id: current_user.id, item_id: @item.id)
    @bookmark.destroy
  end


  private

  def set_item
    @item = Item.find(params[:item_id])
  end

end


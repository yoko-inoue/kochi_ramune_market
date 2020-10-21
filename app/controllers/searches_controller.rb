class SearchesController < ApplicationController
  before_action :set_ransack

  def index
    @items = Item.search(params[:keyword]).limit(132)
    @search = params[:keyword]
    #@items = Item.where('name LIKE(?) OR description LIKE(?)', "%#{@search}%", "%#{@search}%").order(sort)
    sort = params[:sort] || "created_at DESC"
    @count = @items.count
    if @count == 0
      @items = Item.order(sort)
    end
  end
end

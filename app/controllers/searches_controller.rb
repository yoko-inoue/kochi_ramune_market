class SearchesController < ApplicationController
  def index
    @items = Item.search(params[:keyword]).limit(132)
    @search = params[:keyword]
  end

end

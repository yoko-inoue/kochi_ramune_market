class SearchesController < ApplicationController
  before_action :set_ransack

  def index
    @items = Item.search(params[:keyword]).limit(132)
    @search = params[:keyword]
  end
end

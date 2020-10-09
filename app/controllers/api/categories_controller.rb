class Api::CategoriesController < ApplicationController
  def index
    @initial = "no"
    if params[:category_id].in?(['','child','grand_child'])
      @categories = []
      if params[:category_id] == "child"
        @initial = "child"
      elsif params[:category_id] == "grand_child"
        @initial = "grand_child"
      else
        @initial = "parent"
      end
    else
      category = Category.find(params[:category_id])
      @categories = category.children
    end
  end
end
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
  def show

    if params[:id] == "0"
      @categories = Category.where(ancestry:nil)
    else
      @categories = Category.find(params[:id]).children
    end

    respond_to do |format|
      format.html{
        if params[:id] == "0"
          redirect_to category_all_items_path
        else
          redirect_to category_all_items_path(category_id: params[:id])
        end
      }
      format.json{
        render json: @categories
      }
    end 

  end
end
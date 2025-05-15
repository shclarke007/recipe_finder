
class RecipesController < ApplicationController
  def index; end

  def search
    @ingredients = search_params[:ingredients] 
    
    if @ingredients.present?
      set_search_results
      render :search_results
    else
      @recipes = [] 
      render :index
    end
  end

  def show
    @recipe = Recipe.find(params[:id])

    @ingredients = params[:ingredients]
    @page = params[:page]
  end

  private

  def search_params
    params.permit(:ingredients)
  end

  def set_search_results
    @search_results = Recipe.search_by_ingredients(@ingredients)
    @pagy, @recipes = pagy(@search_results, items: 10)
  end
  
end

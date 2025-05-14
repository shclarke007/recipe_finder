
class RecipesController < ApplicationController
  def index; end

  def search
    @ingredients = search_params[:ingredients] 

    if @ingredients.present?
      @search_results = Recipe.search_by_ingredients(@ingredients)

      @pagy, @recipes = pagy(@search_results, items: 10)
      render :search_results
    else
      @recipes = [] 
      render :index
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def search_params
    params.permit(:ingredients)
  end
  
end

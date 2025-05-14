class RecipesController < ApplicationController
  def index;end

  def search
    @ingredients = params[:ingredients] 

    if @ingredients.present?
      @recipes = Recipe.search_by_ingredients(@ingredients)
    else
      @recipes = [] 
    end

    render :search_results
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end

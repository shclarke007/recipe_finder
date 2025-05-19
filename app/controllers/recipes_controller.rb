
class RecipesController < ApplicationController
  def index
    @search = Search.new(search_params)
    @categories = Recipe.all.distinct.pluck(:category).sort
    @recipes = []
  end

  def search
    @search = Search.new(search_params)

    if @search.valid?
      set_search_results
      render :search_results
    else
      @error_message = "Please enter at least one search criteria."
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
  
  def set_search_results
    @search_results = @search.run_search
    @pagy, @recipes = pagy(@search_results, items: 10)
  end

  def search_params
    params.fetch(:search, {}).permit(:ingredients, :category).to_h
  end
  
end
